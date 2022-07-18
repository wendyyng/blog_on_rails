class CommentsController < ApplicationController

    # =============CALLBACKS=====================
    before_action :find_post
    # ==============CREATE========================
    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post
        if @comment.save
        redirect_to post_path(@post), notice: "Comment created!"
        else
         @comments = @post.comments.order(created_at: :desc)
      render '/posts/show', status: 303
    end
    end

    # ================DELETE=========================
    def destroy
        @comment = Comment.find params[:id]
        @comment.destroy
        redirect_to post_path(@post), notice: "Comment deleted"
    end

    private

    def find_post
        @post = Post.find params[:post_id]
    end
end
