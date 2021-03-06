class PostsController < ApplicationController
  before_action :authorised
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new; end

  def create
    new_post = Post.new post_params

    redirect_to "/users/#{session[:id]}" if new_post.save
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    post = Post.find params[:id]
    post.update({ description: params[:description] })
    redirect_to "/users/#{session[:id]}"
  end

  def destroy
    Post.destroy(params[:id])
    redirect_to "/users/#{session[:id]}"
  end

  private

  def post_params
    {
      image: params[:image],
      description: params[:description],
      user_id: session[:id],
    }
  end

  def authorised
    redirect_to root_path unless session[:id]
  end
end
