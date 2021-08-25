class MainController < ApplicationController
  def index
    flash[:notice] = "Logged in succesfully"
    flash[:alert] = "Invalid email or password"
  end
end