# frozen_string_literal: true

RSpec.describe SaveOrder, type: :service do
  describe '.call' do
    let(:service) { described_class.call(order) }
    let(:order) { attributes_for(:order, timestamp: Time.zone.now.to_s).merge(customer: customer) }
    let(:customer) { create(:customer) }

    it { expect(service).to be_success }
    it { expect { service }.to change(Order, :count).from(0).to(1) }
    it { expect { service }.not_to change(EventErrorLog, :count) }

    context 'when order is invalid' do
      let(:order) { attributes_for(:order, amount: nil, timestamp: Time.zone.now.to_s) }

      it { expect(service).not_to be_success }
      it { expect { service }.to change(EventErrorLog, :count).from(0).to(1) }
    end
  end
end
