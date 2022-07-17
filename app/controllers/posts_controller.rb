class PostsController < ApplicationController

    # =============CALLBACKS=====================
    before_action :find_post, only: [:edit, :update, :show, :destroy]
    # ==============CREATE========================
    def new

    end

    def create

    end
    # ================READ========================
    def index

    end

    def show

    end
    # ===============UPDATE==========================
    def edit

    end

    def update

    end
    # ================DELETE=========================
    def destroy

    end

    private

    def find_post

    end

    def post_params

    end

end
