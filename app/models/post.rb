# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  after_create_commit :enqueue_delivery

  class << self
    def cache_key_for(id:)
      "cached_post/#{id}"
    end

    def id_from_cache_key(key:)
      key.split('/').last
    end
  end

  def enqueue_delivery
    PostDeliveryJob.perform_async(post_id: self.id)
  end

  def deliver_to_followers
    recipients = user.followers + [self.user]
    recipients.each do |follower|
      follower.add_to_cache(post: self)
    end
  end
end
