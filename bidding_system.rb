# bidding_system.rb

class Agent
  def initialize; end
  def get_bid_increase; end
end

class Bidding
  MAX_ROUNDS = 1000

  def initialize(agents)
    @agents = agents
    @bids = Array.new(agents.size, 0)
    @active = Array.new(agents.size, true)
    @highest_bid = 0
    @rounds = 0
  end

  def run
    loop do
      @rounds += 1
      raise "Maximum bidding rounds exceeded" if @rounds > MAX_ROUNDS

      @agents.each_with_index do |agent, index|
        next unless @active[index]

        begin
          increase = agent.get_bid_increase
          new_bid = @bids[index] + increase

          if new_bid > @highest_bid
            @bids[index] = new_bid
            @highest_bid = new_bid
          elsif new_bid < @highest_bid
            @active[index] = false
          end
        rescue
          @active[index] = false
        end
      end

      active_bids = @bids.each_with_index.select { |_, i| @active[i] }.map(&:first)
      return { bids: @bids, active: @active } if active_bids.uniq.size <= 1

      @highest_bid = active_bids.max || 0
    end
  end
end

class FixedBidAgent < Agent
  def initialize(bid_increase)
    @bid_increase = bid_increase
  end

  def get_bid_increase
    @bid_increase
  end
end

class IncrementalBidAgent < Agent
  def initialize(increases)
    @increases = increases
    @current_index = 0
  end

  def get_bid_increase
    raise "No more bids" if @current_index >= @increases.size
    @increases[@current_index].tap { @current_index += 1 }
  end
end

class ErrorAgent < Agent
  def get_bid_increase
    raise "Bidding error"
  end
end
