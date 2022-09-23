# frozen_string_literal: true

# Represents individual users that can authenticate with the application.
class User < ApplicationRecord
  has_secure_token :confirmation_token
  has_secure_password
end
