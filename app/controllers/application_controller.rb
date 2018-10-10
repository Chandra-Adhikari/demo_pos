class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session
  helper_method :current_user
	
   def current_user
  	 current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
   end

   def require_user
  	 # redirect_to root_path unless current_user
	    unless current_user.present?
			redirect_to new_session_path
		end
   end
end
