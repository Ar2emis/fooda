# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    amount { rand(1.0..200.0).round(2) }
    utc_offset { ActiveSupport::TimeZone.all.map(&:utc_offset).sample }
    points { rand(CalculatePoints::POINTS_RANGE) }
    customer
  end
end
