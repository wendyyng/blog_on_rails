class UsersController < ApplicationController
   # =============CALLBACKS=====================
   before_action :find_user, only: [:update]  
  
  # ==============CREATE========================
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
    # ===============UPDATE==========================
    def edit
      @user = current_user
    end

    def update
      if current_user.update(user_params)
          redirect_to root_path
        else
          render :edit
        end
    end

    def pass_edit
      @user = current_user
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
    
end
