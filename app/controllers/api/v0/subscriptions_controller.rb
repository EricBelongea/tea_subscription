class Api::V0::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  before_action :find_customer, only: %i[ create index ]
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

  # GET /api/v0/customers/:customer_id/subscriptions
  def index
    if @customer
      render json: SubscriptionSerializer.new(@customer.subscriptions)
    else
      render json: { status: 404, error: @customer.errors.full_messages }, status: :not_found
    end
  end

  private

  def find_customer
    if !params[:customer_id]
      render json: { error: "You must login or create an account", status: 400}, status: :bad_request
    else
      @customer = Customer.find(params[:customer_id])
    end
  end

  def subscription_params
    params.permit(:title, :status, :price, :frequency)
  end

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)), status: :not_found
  end
end