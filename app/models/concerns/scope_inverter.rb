# frozen_string_literal: true

# Adds an `inverse_of` scope that receives the name of an existing scope, and generates a scope that inverts the WHERE
# conditions of that scope.
module ScopeInverter
  extend ActiveSupport::Concern

  included do
    scope :inverse_of, ->(scope) { self.and(klass.send(scope).invert_where) }
  end
end
