# frozen_string_literal: true

# User authentication and session management controller.
class SessionsController < ApplicationController
  before_action :logged_in?, only: %i[index destroy]

  def index; end

  def new
    flash.keep(:redirect)
  end

  def create
    session[:jwt] = User
                    .find_and_authenticate_by!(**session_create_params.to_h.symbolize_keys)
                    .login!(created_from: request.remote_ip)

    redirect_to redirect_target
  rescue Bovine::Errors::UserAuthenticationError
    flash[:error] = :user_authentication
    flash.keep(:redirect)

    redirect_to action: :new
  end

  def destroy; end

  private

  def redirect_target
    flash[:redirect] || root_url
  end

  def session_create_params
    params.require(:user).permit(:email, :password)
  end
end
