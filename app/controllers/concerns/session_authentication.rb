# frozen_string_literal: true

# Adds session authentication to a controller and provides helper methods to access the current user and session from
# the controller and its actions and views.
module SessionAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_session, :current_user, :logged_in?

    after_action :refresh_session, if: :logged_in?

    rescue_from HTTP::Errors::UnauthorizedError, with: :rescue_http_unauthorized
  end

  protected

  def current_session
    @current_session ||= session_from_jwt
  end

  def current_user
    @current_user ||= current_session.user
  end

  def logged_in?
    @current_session.present?
  end

  private

  def jwt
    @jwt ||= session[:jwt]
  end

  def redirect_params
    params.permit(:controller, :action)
  end

  def refresh_session
    session[:jwt] = current_session.to_jwt
  end

  def rescue_http_unauthorized
    session.delete(:jwt)

    flash[:redirect] = redirect_params
    flash[:error] = :unauthorized

    redirect_to new_session_url
  end

  def session_from_jwt
    Session.from_jwt(jwt).tap do |jwt_session|
      jwt_session.update!(last_accessed_from: request.remote_ip, last_accessed_at: Time.zone.now)
    end
  rescue ActiveRecord::RecordNotFound,
         JWT::DecodeError,
         JWT::ExpiredSignature,
         JWT::ImmatureSiganture,
         JWT::VerificationError
    raise HTTP::Errors::UnauthorizedError
  end
end
