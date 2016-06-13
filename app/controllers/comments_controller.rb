class CommentsController < ApplicationController
  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user: current_user))

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.required(:comment).permit(:body)
  end
end
