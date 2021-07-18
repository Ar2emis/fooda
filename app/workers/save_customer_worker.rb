# frozen_string_literal: true

class SaveCustomerWorker < ApplicationWorker
  include Sidekiq::Worker

  def perform(customer)
    SaveCustomer.call(customer.deep_symbolize_keys)
  end
end
