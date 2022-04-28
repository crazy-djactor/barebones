class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:name, :body).merge(user_id: current_user.id))

    redirect_to post_path(@post)
  end

  private
    def post_params
      params.require(:comment).permit(:name, :body)
    end
end
