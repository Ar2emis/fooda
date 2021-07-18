# frozen_string_literal: true

class SaveOrdersWorker < ApplicationWorker
  include Sidekiq::Worker

  def perform(customer_name, orders)
    customer = Customer.find_by(name: customer_name)
    orders.each { |order| SaveOrder.call(order.symbolize_keys.merge(customer: customer)) }
  end
end
