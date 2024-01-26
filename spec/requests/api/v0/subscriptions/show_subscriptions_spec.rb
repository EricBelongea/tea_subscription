require "rails_helper"

RSpec.describe "Customer Subscriptions Show" do
  before(:each) do
    @customer = create(:customer)
    params = {
      title: "My First Tea Order",
      status: true,
      price: 5,
      frequency: 1,
      user_id: @customer.id
    }
    
    post api_v0_subscriptions_path, params: params
    rb = JSON.parse(response.body, symbolize_names: true)

    @subscription = Subscription.find(rb[:data][:id])
  end

  describe '#Happy-Pathing' do
    it 'Shows a customers One active subscription' do
      get api_v0_customer_subscription_path(@customer, @subscription)
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(rb[:data].count).to eq(1)
      
      rb[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscription")
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes][:title]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:frequency)
        expect(subscription[:attributes][:frequency]).to be_a(Integer)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes][:status]).to be_truthy.or be_falsey
      end

    end
  end
end