class UsersController < ApplicationController
   # =============CALLBACKS=====================
   before_action :find_user, only: [:edit, :update, :pass_edit, :pass_update]  
  
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
      # @user = current_user
    end

    def update
      if current_user.update(user_params)
          redirect_to root_path
          flash.notice = "Account updated successfully!"
        else
          render :edit
          flash.notice = "Error!"
        end
    end
  

    def pass_edit
    end
  
    def pass_update  
      if current_user
        if params[:current_user] != current_user.password
          redirect_to root_path
          flash.notice = "Incorrect Password!"
        else
          redirect_to root_path
          flash.notice = "Password updated successfully!"
        end
      end
    end

  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def pass_params
    params.require(:user).permit(:name, :email, :current_password, :new_password, :password_confirmation)
  end

end
