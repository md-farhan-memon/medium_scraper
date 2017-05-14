class UsersController < ApplicationController
  before_action :restrict_if_logged_in, except: [:logout]

  def new
  end

  def new_session
  end

  def create
    if User.create(user_params)
      redirect_to '/' and return
    else
      redirect_to new_users_path
    end
  end

  def login
    if (user = User.find_by_email(user_params[:email])).present? && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to '/' and return
    else
      redirect_to new_session_users_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to new_session_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def restrict_if_logged_in
    redirect_to '/' if current_user
  end

end
