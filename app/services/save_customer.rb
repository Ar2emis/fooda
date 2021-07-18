# frozen_string_literal: true

class SaveCustomer < ApplicationService
  attr_reader :customer

  def initialize(customer_data)
    super
    @customer_data = customer_data
    @orders_data = customer_data.delete(:orders) || []
  end

  def call
    @customer = Customer.create(name: @customer_data[:name], created_at: @customer_data[:timestamp])
    return @orders_data.each { |order_data| SaveOrder.call(order_data.merge(customer: @customer)) } if customer.valid?

    SaveEventErrorLog.call(@customer_data, customer.errors.to_hash)
    failure
  end
end
