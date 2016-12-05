class PostsController < ApplicationController
  layout :layout
  before_action :authenticate_user!, only: [:new, :edit, :index_admin]

  def index
    @posts = Post.latest_posts_cached
  end

  def tagged_with
    @posts = Post.tagged_with(params[:tag]).decorate if params[:tag]
  end

  def search
    @posts = Post.search(params[:q]).records.decorate if params[:q]
  end

  def index_admin
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = find_post
  end

  def show
    @post = find_post.decorate
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to list_posts_path, notice: 'Post was successfully created!'
    else
      render 'new'
    end
  end

  def update
    @post = find_post

    if @post.update(post_params)
      redirect_to list_posts_path, notice: 'Post was successfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @post = find_post
    @post.destroy

    redirect_to list_posts_path, notice: 'Post was successfully deleted!'
  end

  private

  def find_post
    Post.friendly.find(params[:id])
  end

  def post_params
    params.required(:post).permit(:title, :subtitle, :body, :tag_list)
  end

  def layout
    if %w(new edit index_admin create update).include?(action_name)
      'admin'
    elsif %w(show).include?(action_name)
      'post'
    else
      'application'
    end
  end
end
