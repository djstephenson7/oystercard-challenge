class Oystercard
  attr_reader :balance, :station, :journey_history, :journey_hash

  LIMIT = 90
  MINIMUM = 2

  def initialize
    @balance = 0
    @journey = false
    @journey_history = []
    @journey_hash = {}
  end

  def top_up(money)
    raise "You have exceeded your £#{LIMIT} limit!" if @balance + money > LIMIT
    @balance += money
  end

  def pay_fare(price)
    @balance -= price
  end

  def touch_in(station)
    raise "Insufficient balance!" if MINIMUM > @balance
    @journey_hash[:entry_station] = station
    @journey = true
  end

  def in_journey?
    @journey
  end

  def touch_out(exit_station)
    @journey_hash[:exit_station] = exit_station
    @journey = false
    @balance -= MINIMUM
    @journey_history << @journey_hash
    @journey_hash = nil
  end
end
