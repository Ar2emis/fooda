# frozen_string_literal: true

class SaveOrder < ApplicationService
  def initialize(order_data)
    super
    @order_data = order_data
  end

  def call
    transaction_time = Time.parse(@order_data[:timestamp])
    order = Order.create(
      amount: @order_data[:amount], utc_offset: transaction_time.utc_offset,
      points: CalculatePoints.call(@order_data[:amount].to_d, transaction_time).points,
      customer: @order_data[:customer], created_at: @order_data[:timestamp]
    )
    return if order.valid?

    SaveEventErrorLog.call(@order_data, order.errors.to_hash)
    failure
  end
end
