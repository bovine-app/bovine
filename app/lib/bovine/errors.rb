# frozen_string_literal: true

module Bovine
  module Errors
    # Represents a generic user authentication error without exposing whether or not an account exists.
    class UserAuthenticationError < StandardError; end
  end
end
