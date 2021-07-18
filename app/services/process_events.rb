# frozen_string_literal: true

class ProcessEvents < ApplicationService
  NEW_CUSTOMER = 'new_customer'
  NEW_ORDER = 'new_order'

  attr_reader :customers, :grouped_orders

  def initialize(events)
    super
    @events = events
  end

  def call
    separate_events
    map_orders_with_customers
  end

  private

  def separate_events
    grouped_events = @events.group_by { |event| event[:action] }
    @customers = grouped_events[NEW_CUSTOMER]
    @orders = grouped_events[NEW_ORDER]
  end

  def map_orders_with_customers
    @grouped_orders = @orders.group_by { |order| order[:customer] }
    @customers.each do |customer|
      customer[:orders] = @grouped_orders.delete(customer[:name]) || []
    end
  end
end
