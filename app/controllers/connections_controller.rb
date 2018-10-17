class ConnectionsController < ApplicationController
  before_action :auth_user

  def create
    Connection.create(
      follower_id: session[:user_id],
      following_id: params[:following_id]
    )
  rescue => e
    Rails.logger.error(e.message)
  ensure
    redirect_to posts_url
  end

  def destroy
    Connection.find_by(
      follower_id: session[:user_id],
      following_id: params[:id]
    )&.destroy
  rescue => e
    Rails.logger.error(e.message)
  ensure
    redirect_to posts_url
  end
end
