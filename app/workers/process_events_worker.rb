# frozen_string_literal: true

class ProcessEventsWorker < ApplicationWorker
  include Sidekiq::Worker

  def perform(events)
    service = ProcessEvents.call(events.map(&:deep_symbolize_keys))
    Sidekiq::Client.push_bulk('class' => SaveCustomerWorker, 'args' => service.customers.map { |customer| [customer] })
    Sidekiq::Client.push_bulk(
      'class' => SaveOrdersWorker, 'args' => service.grouped_orders.map { |customer, orders| [customer, orders] }
    )
  end
end
