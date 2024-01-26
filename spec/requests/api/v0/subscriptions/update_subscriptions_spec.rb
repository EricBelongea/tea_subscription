require "rails_helper"

RSpec.describe "Subscription Uopdate" do
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

  describe '#happy-pathing' do
    it 'Can update' do
      params = {
        title: "Updated Subs!",
        status: false,
        price: 5,
        frequency: 1,
        customer_id: @customer.id
      }

      patch api_v0_subscription_path(@subscription), params: params
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(rb[:data]).to have_key(:id)
      expect(rb[:data]).to have_key(:type)
      expect(rb[:data][:type]).to eq("subscription")
      expect(rb[:data]).to have_key(:attributes)
      expect(rb[:data][:attributes]).to have_key(:title)
      expect(rb[:data][:attributes][:title]).to be_a(String)
      
      expect(rb[:data][:attributes]).to have_key(:frequency)
      expect(rb[:data][:attributes][:frequency]).to be_a(Integer)
      expect(rb[:data][:attributes]).to have_key(:price)
      expect(rb[:data][:attributes][:price]).to be_a(Integer)
      expect(rb[:data][:attributes]).to have_key(:status)
      expect(rb[:data][:attributes][:status]).to_not be(true)
      expect(rb[:data][:attributes][:status]).to be(false)

      updated_sub = Subscription.find(rb[:data][:id])

      expect(updated_sub.id).to eq(@subscription.id)
      expect(updated_sub.price).to eq(@subscription.price)
      expect(updated_sub.frequency).to eq(@subscription.frequency)
      expect(updated_sub.customer_id).to eq(@subscription.customer_id)
      
      expect(updated_sub.title).to_not eq(@subscription.title)
      expect(updated_sub.status).to_not eq(@subscription.status)
    end
  end

  describe '#sad-pathing' do
    it 'Missing title' do
      params = {
        title: "",
        status: true,
        price: 5,
        frequency: 1,
        customer_id: @customer.id
      }
    
      patch api_v0_subscription_path(@subscription), params: params
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(rb[:error]).to eq("Title can't be blank")
      expect(rb[:status]).to eq(400)
    end

    it 'Missing status' do
      params = {
        title: "First Order",
        status: "",
        price: 5,
        frequency: 1,
        customer_id: @customer.id
      }
    
      patch api_v0_subscription_path(@subscription), params: params
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(rb[:error]).to eq("Status is not included in the list")
      expect(rb[:status]).to eq(400)
    end

    it 'Missing price' do
      params = {
        title: "First Order",
        status: true,
        price: "",
        frequency: 1,
        customer_id: @customer.id
      }
    
      patch api_v0_subscription_path(@subscription), params: params
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(rb[:error]).to eq("Price is not a number")
      expect(rb[:status]).to eq(400)
    end

    it 'Missing frequency' do
      params = {
        title: "First Order",
        status: true,
        price: 4,
        frequency: "",
        customer_id: @customer.id
      }
    
      patch api_v0_subscription_path(@subscription), params: params
      rb = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(rb[:error]).to eq("Frequency is not a number")
      expect(rb[:status]).to eq(400)
    end
  end
end