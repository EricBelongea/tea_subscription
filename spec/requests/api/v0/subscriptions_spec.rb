require "rails_helper"

RSpec.describe "Subscriptions Requests" do
  it "Subscribe a Customer to a tea Subscription" do
    customer = create(:customer)
    require 'pry'; binding.pry
    customer.subscriptions.create(:subscription)
    require 'pry'; binding.pry

  end
end