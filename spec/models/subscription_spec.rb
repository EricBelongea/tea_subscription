require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
    # it { should validate_inclusion_of(:status) }
    it { should validate_numericality_of(:frequency) }
    it { should validate_numericality_of(:price) }
  end

  describe 'Relations' do
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:teas).through(:tea_subscriptions) }
    it { should belong_to(:customer) }
  end
end