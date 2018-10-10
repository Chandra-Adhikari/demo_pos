class SessionsController < ApplicationController
  def new
    redirect_to products_path if current_user.present?
  end

  def create
    if @user = User.find_by(email: params[:session][:email])
      if @user && @user.valid_password?(params[:session][:password])
					session[:user_id] = @user.id.to_s
          flash[:notice] = "You have successfully logged In."
          redirect_to products_path
      else
     		redirect_to new_session_path
        flash[:error] = "Invalid Email or Password"
      end
    else
      redirect_to new_session_path
      flash[:error] = "Invalid Email, Please try again."
    end
	end

	def destroy
    session[:user_id] = nil
    # flash[:success] = "You have successfully logged out."
    redirect_to new_session_path
	end
end
