class PasswordsController < ApplicationController
  before_action :require_user_logged_in!

  def edit
  end
  def update
    if Current.user.update(update_params)
      redirect_to root_path, notice: "Password Updated"
    else
      render :edit
    end
  end

  private
  def update_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
