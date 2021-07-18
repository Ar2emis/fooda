# frozen_string_literal: true

RSpec.describe ProcessEvents, type: :service do
  describe '.call' do
    let(:service) { described_class.call(events) }
    let(:events) do
      JSON.parse(File.read("#{fixture_path}/events.json"), symbolize_names: true)[:events]
    end
    let(:customers_count) { events.count { |event| event[:action] == ProcessEvents::NEW_CUSTOMER } }

    it { expect(service.grouped_orders).to be_empty }
    it { expect(service.customers.count).to eq customers_count }

    it 'maps customers with their orders' do
      service.customers.each do |customer|
        orders = events.select { |event| event[:customer] == customer[:name] }
        expect(orders).to eq customer[:orders]
      end
    end

    context 'when orders without customer exists' do
      let(:events) do
        JSON.parse(File.read("#{fixture_path}/events_without_customer.json"), symbolize_names: true)[:events]
      end

      it { expect(service.grouped_orders).not_to be_empty }
    end
  end
end
