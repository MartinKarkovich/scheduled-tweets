# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user.present?
      # send email
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email exists, we have sent an email to reset the password"
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your token has expired. Please try again."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Succesfully reset password."
    else
      render :edit
    end
  end

  private
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
