# frozen_string_literal: true

RSpec.describe ProcessEventsWorker, type: :worker do
  let(:invokation) do
    described_class.perform_async([])
  end
  let(:service) { instance_double(ProcessEvents) }

  before do
    allow(service).to receive(:call)
    allow(service).to receive(:customers).and_return([])
    allow(service).to receive(:grouped_orders).and_return({})
    allow(ProcessEvents).to receive(:new).and_return(service)
  end

  it 'invokes job' do
    Sidekiq::Testing.fake! do
      expect { invokation }.to change(described_class.jobs, :size).by(1)
    end
  end

  it 'calls ProcessEvents service' do
    expect(ProcessEvents).to receive(:call).and_return(service)
    invokation && described_class.drain
  end

  context 'when customers exist' do
    let(:worker_args) do
      { 'class' => SaveCustomerWorker, 'args' => service.customers.map { |customer| [customer] } }
    end

    before do
      allow(service).to receive(:customers).and_return([1])
      allow(Sidekiq::Client).to receive(:push_bulk)
    end

    it 'invokes SaveCustomerWorkers' do
      expect(Sidekiq::Client).to receive(:push_bulk).with(**worker_args)
      invokation && described_class.drain
    end
  end

  context 'when grouped orders exist' do
    let(:worker_args) do
      { 'class' => SaveOrdersWorker, 'args' => service.grouped_orders.map { |customer, orders| [customer, orders] } }
    end

    before do
      allow(service).to receive(:grouped_orders).and_return({ one: 1 })
      allow(Sidekiq::Client).to receive(:push_bulk)
    end

    it 'invokes SaveCustomerWorkers' do
      expect(Sidekiq::Client).to receive(:push_bulk).with(**worker_args)
      invokation && described_class.drain
    end
  end
end
