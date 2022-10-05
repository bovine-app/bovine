# frozen_string_literal: true

# A podcast feed that can be subscribed to and refreshed.
class Feed < ApplicationRecord
  attribute :url, Bovine::Types::URL.new

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
end
