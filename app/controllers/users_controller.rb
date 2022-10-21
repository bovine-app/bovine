# frozen_string_literal: true

# User account self-management controller.
class UsersController < ApplicationController
  before_action :logged_in?, except: %i[new create]

  def new
    @user = User.new
  end

  def create
    User.create!(user_create_params)
    redirect_to root_url
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
