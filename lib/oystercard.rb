
class Oystercard
  attr_reader :balance

  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "You have exceeded your £#{LIMIT} limit!" if @balance + money > LIMIT
    @balance = @balance + money
  end

  def pay_fare(price)
    @balance = @balance - price
  end
end
