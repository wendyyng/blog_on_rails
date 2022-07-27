class CommentsController < ApplicationController

    # =============CALLBACKS=====================
    before_action :find_post
    before_action :authenticated_user!
    # ==============CREATE========================
    def create
        # if current_user.present?
            @comment = Comment.new(params.require(:comment).permit(:body))
            @comment.post = @post
            @comment.user = current_user

            if @comment.save
                redirect_to post_path(@post), notice: "Comment created!"
            else
                @comments = @post.comments.order(created_at: :desc)
                render '/posts/show', status: 303
            end
        # else
        #     redirect_to new_session_path
        #     flash[:alert] = "You need to sign in first!"
        # end
        
    end

    # ================DELETE=========================
    def destroy
        @comment = Comment.find params[:id]
        if can?(:crud, @comment)
            @comment.destroy
            redirect_to post_path(@post), notice: "Comment deleted"
        else
            redirect_to root_path, alert: "Not authorized"
        end
    end

    private

    def find_post
        @post = Post.find params[:post_id]
    end
end
