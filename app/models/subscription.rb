# frozen_string_literal: true

# Subscription of a user to a podcast feed.
class Subscription < ApplicationRecord
  belongs_to :feed
  belongs_to :user

  validates :feed, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :feed }
end
