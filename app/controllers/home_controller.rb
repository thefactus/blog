class HomeController < ApplicationController
  def index
    @posts = Post.latest_posts.decorate.first(9)
  end
end
