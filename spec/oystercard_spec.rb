require 'oystercard'

describe OysterCard do
  describe 'balance' do
    it "checks the balance" do
      expect(subject.balance).to eq 0
    end
  end
end
