class UsersController < ApplicationController

    def new
        @user = User.new
      end
    
    def create
        @user = User.new params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )

        if @user.save
          session[:user_id] = @user.id
          flash.notice = "Signed up!"
          redirect_to root_path
        else
          render :new, status: 303
        end 
    
    end

    def edit
    end
    
end
