# frozen_string_literal: true

module Bovine
  module Types
    # Casts a value between a Ruby URI object and a string for ActiveRecord storage.
    # :reek:UtilityFunction
    class URL < ActiveRecord::Type::String
      def assert_valid_value(value)
        value.is_a?(URI::HTTP)
      end

      def cast(value)
        URI.parse(value)
      rescue URI::InvalidURIError
        nil
      end

      def serialize(value)
        value.to_s
      end
    end
  end
end
