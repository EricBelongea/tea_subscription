require "rails_helper"

RSpec.describe "Subscriptions Requests" do
  before :each do
    @customer = create(:customer)
    @subscription = create(:subscription, customer: @customer)

  end
  it "Subscribe a Customer to a tea Subscription" do
    require 'pry'; binding.pry

    params = {
      title: "My First Tea Order",
      status: true,
      price: 5,
      frequency: 1,
      user_id: @customer.id
    }
    
    post api_v0_subscriptions_path, params: params

    rb = JSON.parse(response.body, symbolize_names: true)

    
    require 'pry'; binding.pry
  end
end