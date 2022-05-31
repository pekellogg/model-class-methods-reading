class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
    if !params[:author].blank?
      @posts = Post.by_author(params[:author])
    elsif !params[:date].blank?
      params[:date] == "Today" ? @posts = Post.from_today : @posts.old_news
    else
      @posts = Post.all
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to(post_path(@post))
  end

  def update
    @post.update(params.require(:post))
    redirect_to(post_path(@post))
  end

  def edit
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted."
    redirect_to(posts_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :post_status, :author_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
