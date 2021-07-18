# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { FFaker::Name.name }
  end
end
