class Tea < ApplicationRecord 
  validates_presence_of :title, :description, :temperature
  validates_numericality_of :brew_time

  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions
end