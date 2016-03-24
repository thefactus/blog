class PostsController < ApplicationController
  layout 'admin', only: [:new, :edit, :index_admin, :create, :update]
  before_action :authenticate_user!, only: [:new, :edit, :index_admin]
  before_action only: [:show]

  def index
    if params[:q]
      @posts = Post.search(params[:q]).records.decorate
    elsif params[:tag]
      @posts = Post.tagged_with(params[:tag]).decorate
    else
      @posts = Post.latest_posts.decorate
    end
  end

  def index_admin
    @posts = Post.latest_posts
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def show
    @post = Post.friendly.find(params[:id]).decorate
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
    @post = Post.friendly.find(params[:id])

    if @post.update(post_params)
      redirect_to list_posts_path, notice: 'Post was successfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy

    redirect_to list_posts_path, notice: 'Post was successfully deleted!'
  end

  private

  def post_params
    params.required(:post).permit(:title, :subtitle, :body, :tag_list)
  end
end
