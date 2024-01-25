require "rails_helper"

RSpec.describe "Subscription Uopdate" do
  before(:each) do
    @customer = create(:customer)
    @subscription = create(:subscription, customer: @customer)
  end

  describe '#happy-pathing' do
    it 'Can update' do
      
      expect().to eq()
    end
  end
end