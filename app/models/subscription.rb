class Subscription < ApplicationRecord
  validates_presence_of :title
  validates_numericality_of :frequency, :price
  validates :status, inclusion: { in: [true, false] }
  
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end