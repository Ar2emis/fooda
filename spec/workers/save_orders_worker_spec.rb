# frozen_string_literal: true

RSpec.describe SaveOrdersWorker, type: :worker do
  let(:invokation) do
    described_class.perform_async(create(:customer).name, orders)
  end
  let(:orders) do
    [attributes_for(:order).slice(:amount).merge(timestamp: Time.zone.now.to_s)] * rand(1..3)
  end

  before do
    allow(SaveOrder).to receive(:call)
  end

  it 'invokes job' do
    Sidekiq::Testing.fake! do
      expect { invokation }.to change(described_class.jobs, :size).by(1)
    end
  end

  it 'calls SaveOrder service' do
    expect(SaveOrder).to receive(:call).exactly(orders.count).times
    invokation && described_class.drain
  end
end
