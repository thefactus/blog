class HomeController < ApplicationController
  def index
    @posts = Post.latest_posts_cached.first(9)
  end
end
