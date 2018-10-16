class SessionsController < ApplicationController

  def new; end

  def create
    puts session_params
    user = User.find_by(email: session_params[:email], password: session_params[:password])
    redirect_to :new unless user

    session[:user_id] = user.id
    redirect_to posts_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private
  def session_params
    params.fetch(:session, {})
  end
end
