class ApplicationController < ActionController::Base

    private 
    
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
      end
      helper_method :current_user
      # 'helper_method' makes the method also available for the views
    
      def user_signed_in?
        current_user.present?
      end
      helper_method :user_signed_in?
    
      def authenticate_user!
        redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
      end
end
