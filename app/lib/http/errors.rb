# frozen_string_literal: true

module HTTP
  module Errors
    # Base class for errors representing HTTP 4xx statuses.
    class BaseError < StandardError
      def code
        raise NotImplementedError
      end
    end

    # HTTP 401 Unauthorized
    class UnauthorizedError < BaseError
      def code
        :unauthorized
      end
    end
  end
end
