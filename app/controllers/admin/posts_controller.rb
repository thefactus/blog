module Admin
  class PostsController < AdminController
    def index
      @posts = Post.latest_posts_cached
    end

    def show
      @post = find_post.decorate
    end

    def new
      @post = current_user.posts.build
    end

    def edit
      @post = find_post
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
  end
end
