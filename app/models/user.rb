# frozen_string_literal: true

# Represents individual users that can authenticate with the application.
# :reek:MissingSafeMethod { exclude: [authenticate!, find_and_authenticate_by!, login!] }
class User < ApplicationRecord
  include AttributeProtector
  include ScopeInverter

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: { case_sensitive: false }

  has_many :sessions, dependent: :delete_all
  has_many :subscriptions, dependent: :destroy
  has_many :feeds, through: :subscriptions

  scope :confirmed,   -> { inverse_of(:unconfirmed) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }

  has_secure_token :confirmation_token
  has_secure_password

  protect_attributes :confirmation_token, :password, :password_confirmation, :password_digest

  class << self
    def find_and_authenticate_by!(email:, password:)
      find_by!('LOWER(email) = ?', email.downcase).authenticate!(password)
    rescue ActiveRecord::RecordNotFound
      raise Bovine::Errors::UserAuthenticationError
    end
  end

  def authenticate!(password)
    authenticate(password) or raise Bovine::Errors::UserAuthenticationError
  end

  def login!(created_from:)
    sessions.create!(created_from:).to_jwt
  end
end
