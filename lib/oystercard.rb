class Oystercard
  attr_reader :balance

  LIMIT = 90
  MINIMUM = 2

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(money)
    raise "You have exceeded your £#{LIMIT} limit!" if @balance + money > LIMIT
    @balance += money
  end

  def pay_fare(price)
    @balance -= price
  end

  def touch_in
    raise "Insufficient balance!" if MINIMUM > @balance
    @journey = true
  end

  def in_journey?
    @journey
  end

  def touch_out
    @journey = false
  end
end
