class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    redirect_to posts_url if session[:user_id]
  end

  def create
    redirect_to posts_url if session[:user_id]

    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to posts_url
    else
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
