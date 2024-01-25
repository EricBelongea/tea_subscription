class Api::V0::SubscriptionsController < ApplicationController
  before_action :find_customer, only: %i[ create ]

  def create
    subscription = @customer.subscriptions.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      require 'pry'; binding.pry
      render json: { error: subscription.errors.full_messages }, status: :bad_request
    end
  end

  private

  def find_customer
    @customer = Customer.find(params[:user_id])
  end

  def subscription_params
    params.permit(:title, :status, :price, :frequency)
  end
end