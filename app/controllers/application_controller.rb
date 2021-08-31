# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_curent_user

  def set_curent_user
    if session[:user_id]
      Current.user = User.find_by_id(session[:user_id])
    end
  end

  def require_user_logged_in!
    redirect_to sign_in_path, alert: "You must be signed in to do that." unless Current.user
  end
end
