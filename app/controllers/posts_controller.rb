class PostsController < ApplicationController
  before_action :auth_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @user.fetch_cached_feed
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(message: post_params[:message], user_id: @user.id)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.fetch(:post, :message)
  end
end
