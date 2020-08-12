class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    redirect_to profile_path if user_signed_in? && current_user.id == @user.id
  end

  def profile
    redirect_to new_user_session_path unless user_signed_in?

    @user = current_user
  end
end
