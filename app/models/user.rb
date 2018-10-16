class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :connections, dependent: :destroy

  has_many :follower_connections, foreign_key: :following_id, class_name: 'Connection'
  has_many :followers, through: :follower_connections, source: :follower

  has_many :following_connections, foreign_key: :follower_id, class_name: 'Connection'
  has_many :following, through: :following_connections, source: :following

  has_many :following_posts, through: :following, source: :post

  def fetch_feed
    Post.where(user: self.following + [self]).order('created_at DESC')
  end
end
