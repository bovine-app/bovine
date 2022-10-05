# frozen_string_literal: true

FactoryBot.define do
  factory :feed do
    title { Faker::Book.title }
    url { Faker::Internet.url }
    last_checked_at { Faker::Time.backward }
  end
end
