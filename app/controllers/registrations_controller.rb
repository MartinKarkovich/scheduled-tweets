# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(create_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successful"
    else
      render :new
    end
  end

  private
    def create_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
