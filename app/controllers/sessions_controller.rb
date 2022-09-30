# frozen_string_literal: true

# User authentication and session management controller.
class SessionsController < ApplicationController
  def index; end

  def new
    flash.keep(:redirect)
  end

  def create
    session[:jwt] = User
                    .find_and_authenticate_by!(**session_create_params.to_h.symbolize_keys)
                    .login!(created_from: request.remote_ip)

    redirect_to redirect_target, status: :see_other
  rescue Bovine::Errors::UserAuthenticationError
    flash.keep(:redirect)
    redirect_to action: :new, error: t('.user_authentication_error')
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
