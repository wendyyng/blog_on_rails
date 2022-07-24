class PostsController < ApplicationController

    # =============CALLBACKS=====================
    before_action :find_post, only: [:edit, :update, :show, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only:[:edit, :update, :destroy]
    # ==============CREATE========================
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            flash[:notice]= "Post created successfully!"
            redirect_to post_path(@post)
        else
            redirect_to root_path
            flash[:alert]= "Title must be unique and body must has at least 50 characters"
        end
       
        
    end
    # ================READ========================
    def index
        @posts = Post.order(created_at: :desc)
    end

    def show
        @comments = @post.comments.order(created_at: :desc)
        @comment = Comment.new
    end
    # ===============UPDATE==========================
    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
          else
            render :edit
          end
    end
    # ================DELETE=========================
    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless can?(:crud, @post)
      end

    def find_post
        @post = Post.find params[:id]
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

end
