require "rails_helper"

RSpec.describe "Subscriptions Requests" do
  before :each do
    @customer = create(:customer)
    @subscription = create(:subscription, customer: @customer)

  end
  it "Subscribe a Customer to a tea Subscription" do
    require 'pry'; binding.pry
  end
end