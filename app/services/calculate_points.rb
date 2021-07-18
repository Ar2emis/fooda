# frozen_string_literal: true

class CalculatePoints < ApplicationService
  POINTS_RANGE = (3..20).freeze

  attr_reader :points

  def initialize(amount, created_at)
    super
    @amount = amount
    @created_at = created_at
  end

  def call
    divider = case @created_at.hour
              when 12 then 3
              when 11, 13 then 2
              when 10, 14 then 1
              else 4
              end
    order_points = (@amount / divider).ceil.to_i
    @points = POINTS_RANGE.cover?(order_points) ? order_points : 0
  end
end
