# frozen_string_literal: true

class PointsReportQuery
  def self.call
    Customer.left_joins(:orders).select(
      :name, 'sum(orders.points) as points',
      'avg(case when orders.points != 0 then orders.points end) as points_average'
    ).group(:name).order('points desc nulls last')
  end
end
