class Subscription < ApplicationRecord
  validates_presence_of :title, :status
  validates_numericality_of :frequency, :price
  
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end