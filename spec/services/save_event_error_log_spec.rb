# frozen_string_literal: true

RSpec.describe SaveEventErrorLog, type: :service do
  describe '.call' do
    let(:service) { described_class.call(data, errors) }
    let(:data) { attributes_for(:customer) }
    let(:errors) { Customer.create.errors.to_hash }
    let(:orders) { create(:customer) }

    it { expect(service).to be_success }
    it { expect { service }.to change(EventErrorLog, :count).from(0).to(1) }
    it { expect(service.error_log.data.symbolize_keys).to eq data }
    it { expect(service.error_log.event_errors.symbolize_keys).to eq errors }
  end
end
