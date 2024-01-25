class Api::V0::SubscriptionsController < ApplicationController
  before_action :find_customer, only: %i[ create ]
  before_action :find_subscription, only: %i[ update ]

  # POST /api/v0/subscriptions
  def create
    subscription = @customer.subscriptions.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { error: subscription.errors.full_messages.first, status: 400 }, status: :bad_request
    end
  end

  # PUT/PATCH /api/v0/subscriptions/:id
  def update  
    if @subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(@subscription)
    else
      render json: { status: 400, error: @subscription.errors.full_messages.first }, status: :bad_request
    end
  end

  private

  def find_customer
    if !params[:user_id]
      render json: { error: "You must login or create an account", status: 400}, status: :bad_request
    else
      @customer = Customer.find(params[:user_id])
    end
  end

  def subscription_params
    params.permit(:title, :status, :price, :frequency)
  end

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end
end