
class UsersController < ApplicationController
  # =============CALLBACKS=====================
  before_action :find_user, only: [:update]  
  before_action :authenticate_user!, only: [:update, :edit]

 # ==============CREATE========================
 def new
       @user = User.new
 end
   
   def create
       @user = User.new user_params

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
    @user = User.find_by_id current_user.id
   end

   def update
    if @user.update user_params
      redirect_to root_path
      flash.notice = "Account updated successfully!"
      else
         render :edit
         flash.notice = "Error!"
       end
   end
 
   def change_password 
    @user = User.find_by_id current_user.id
   end
 
   def update_password  
    @user = User.find_by_id current_user.id

    @current_password = params[:current_password]
    @new_password = params[:new_password]
    @new_password_confirmation = params[:new_password_confirmation]

    if @user && @user.authenticate(@current_password)

      if @current_password != @new_password && @new_password == @new_password_confirmation
        if @user.update password: @new_password
          flash.alert = 'Password has been updated successfully'
          redirect_to root_path
        end
      elsif @current_password == @new_password
          flash.alert = 'New password has to be different'
          render :change_password, status: 303
      elsif @current_password != @new_password && @new_password != @new_password_confirmation
          flash.alert = 'New passwords do not match'
          render :change_password, status: 303
      end

    else
      flash.alert = 'Error! Please try again!'
      render :change_password, status: 303
    end

  end


 private

 def find_user
   @user = User.find_by_id params[:id]
 end

 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end

end
