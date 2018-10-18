# frozen_string_literal: true

class PostDeliveryJob
  include SuckerPunch::Job

  def perform(post_id:)
    post = Post.find_by(id: post_id)
    return unless post

    post.deliver_to_followers
  end
end
