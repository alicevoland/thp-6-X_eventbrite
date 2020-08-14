class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if user_signed_in? && current_user == @user
      render :profile
    else
      render :show
    end
  end
end
