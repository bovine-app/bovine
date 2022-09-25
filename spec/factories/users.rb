# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :confirmed_user do
      confirmed_at { Faker::Time.backward }
    end
  end
end
