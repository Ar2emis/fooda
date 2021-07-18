# frozen_string_literal: true

RSpec.describe SaveCustomer, type: :service do
  describe '.call' do
    let(:service) { described_class.call(customer) }
    let(:customer) { attributes_for(:customer).slice(:name) }

    it { expect(service).to be_success }
    it { expect { service }.to change(Customer, :count).from(0).to(1) }
    it { expect { service }.not_to change(EventErrorLog, :count) }

    context 'when customer with orders' do
      let(:customer) { attributes_for(:customer).slice(:name).merge(orders: orders) }
      let(:orders) { [attributes_for(:order).slice(:amount).merge(timestamp: Time.zone.now.to_s)] }

      it { expect(service).to be_success }
      it { expect { service }.to change(Customer, :count).from(0).to(1) }
      it { expect { service }.to change(Order, :count).from(0).to(orders.count) }
      it { expect { service }.not_to change(EventErrorLog, :count) }
    end

    context 'when customer is invalid' do
      let(:customer) { attributes_for(:customer, name: '') }

      it { expect(service).not_to be_success }
      it { expect { service }.not_to change(Customer, :count) }
      it { expect { service }.to change(EventErrorLog, :count).from(0).to(1) }
    end
  end
end
