# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :connections, dependent: :destroy

  has_many :follower_connections, foreign_key: :following_id, class_name: 'Connection'
  has_many :followers, through: :follower_connections, source: :follower

  has_many :following_connections, foreign_key: :follower_id, class_name: 'Connection'
  has_many :following, through: :following_connections, source: :following

  def fetch_feed
    Post.eager_load(:user)
        .where(user: following + [self])
        .order('posts.created_at DESC')
  end

  def add_to_cache(post:)
    redis.zadd(cache_key, post.created_at.to_i, post.id)
  end

  def fetch_cached_feed
    cache_keys = redis.zrevrange(cache_key, 0, -1)
                      .map { |id| Post.cache_key_for(id: id) }

    return [] unless cache_keys.any?

    Rails.cache.fetch_multi(*cache_keys, expires: 1.minute, race_condition_ttl: 5.seconds) do |key|
      Post.find_by(id: Post.id_from_cache_key(key: key))
    end.values
  end

  private

  def redis
    @redis ||= Redis.new url: ENV['REDIS_URL']
  end
end
