# frozen_string_literal: true

# Represents individual users that can authenticate with the application.
class User < ApplicationRecord
  include AttributeProtector
  include ScopeInverter

  has_many :sessions, dependent: :delete_all

  scope :confirmed,   -> { inverse_of(:unconfirmed) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }

  has_secure_token :confirmation_token
  has_secure_password

  protect_attributes :confirmation_token, :password, :password_confirmation, :password_digest
end
