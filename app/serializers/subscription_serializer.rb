class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :frequency, :price, :status
end