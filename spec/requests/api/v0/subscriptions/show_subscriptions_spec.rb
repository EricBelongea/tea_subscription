require "rails_helper"

RSpec.describe "Customer Subscriptions Show" do
  before(:each) do
    @customer = create(:customer)
    params = {
      title: "My First Tea Order",
      status: true,
      price: 5,
      frequency: 1,
      customer_id: @customer.id
    }
    
    post api_v0_subscriptions_path, params: params
    rb = JSON.parse(response.body, symbolize_names: true)
    
    @subscription = Subscription.find(rb[:data][:id])
  end

  describe '#Happy-Pathing' do
    it 'Shows a customers One active subscription' do
      get api_v0_customer_subscriptions_path(@customer)
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

    it "Shows multiple Actice subs" do
      params = {
        title: "My Second Tea Order",
        status: true,
        price: 7,
        frequency: 3,
        customer_id: @customer.id
      }
      
      post api_v0_subscriptions_path, params: params

      get api_v0_customer_subscriptions_path(@customer)
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(rb[:data].count).to eq(2)

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

    it "Shows Active and inactive Subs" do
      params = {
        title: "My Second Tea Order",
        status: true,
        price: 7,
        frequency: 3,
        customer_id: @customer.id
      }
      
      post api_v0_subscriptions_path, params: params

      params1 = {
        title: "My Third Tea Order",
        status: false,
        price: 7,
        frequency: 10,
        customer_id: @customer.id
      }
      
      post api_v0_subscriptions_path, params: params1

      params2 = {
        title: "My Fourth Tea Order",
        status: false,
        price: 2,
        frequency: 4,
        customer_id: @customer.id
      }
      
      post api_v0_subscriptions_path, params: params2

      get api_v0_customer_subscriptions_path(@customer)
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(rb[:data].count).to eq(4)

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

  describe '#sad-pathing' do
    it 'Not a Customer ID' do
      get api_v0_customer_subscriptions_path(666999666)
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(rb).to have_key(:error_object)
      expect(rb[:error_object]).to have_key(:message)
      expect(rb[:error_object][:message]).to eq("Couldn't find Customer with 'id'=666999666")
      expect(rb[:error_object]).to have_key(:status)
      expect(rb[:error_object][:status]).to eq(404)
    end
  end
end