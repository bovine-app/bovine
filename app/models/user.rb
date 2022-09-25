# frozen_string_literal: true

# Represents individual users that can authenticate with the application.
class User < ApplicationRecord
  include AttributeProtector

  has_many :sessions, dependent: :delete_all

  has_secure_token :confirmation_token
  has_secure_password

  protect_attributes :confirmation_token, :password, :password_confirmation, :password_digest
end
