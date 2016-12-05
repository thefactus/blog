class PostsController < ApplicationController
  def index
    @posts = Post.latest_posts_cached
  end

  def tagged_with
    @posts = Post.tagged_with(params[:tag]).decorate if params[:tag]
  end

  def search
    @posts = Post.search(params[:q]).records.decorate if params[:q]
  end

  def show
    @post = find_post.decorate
  end

  private

  def find_post
    Post.friendly.find(params[:id])
  end
end
