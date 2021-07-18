# frozen_string_literal: true

RSpec.describe SaveCustomerWorker, type: :worker do
  let(:invokation) do
    described_class.perform_async({ name: FFaker::Name.name, orders: [] })
  end

  before do
    allow(SaveCustomer).to receive(:call)
  end

  it 'invokes job' do
    Sidekiq::Testing.fake! do
      expect { invokation }.to change(described_class.jobs, :size).by(1)
    end
  end

  it 'calls SaveCustomer service' do
    expect(SaveCustomer).to receive(:call)
    invokation && described_class.drain
  end
end
