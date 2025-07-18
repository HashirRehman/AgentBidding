# bidding_system_spec.rb

require 'rspec'
require_relative '../bidding_system'

RSpec.describe Bidding do
  describe '#run' do
    it 'allows a FixedBidAgent to win over a weaker one' do
      a1 = FixedBidAgent.new(5)
      a2 = FixedBidAgent.new(2)
      bidding = Bidding.new([a1, a2])
      result = bidding.run

      expect(result[:bids]).to all(be_a(Integer))
      expect(result[:active].count(true)).to eq(1)
    end

    it 'handles IncrementalBidAgent properly' do
      a1 = IncrementalBidAgent.new([1, 2, 3])
      a2 = IncrementalBidAgent.new([1, 2, 2])
      bidding = Bidding.new([a1, a2])
      result = bidding.run

      expect(result[:active].count(true)).to be <= 1
    end

    it 'deactivates ErrorAgent on error' do
      a1 = ErrorAgent.new
      a2 = FixedBidAgent.new(3)
      bidding = Bidding.new([a1, a2])
      result = bidding.run

      expect(result[:active][0]).to be false
    end

    it 'handles agents with no more increments' do
      a1 = IncrementalBidAgent.new([1])
      a2 = IncrementalBidAgent.new([1])
      bidding = Bidding.new([a1, a2])
      result = bidding.run

      expect(result[:bids].sum).to be > 0
    end
  end
end
