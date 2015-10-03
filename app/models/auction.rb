class Auction < ActiveRecord::Base
  include  AASM
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :details, presence: true
  validates :ending_date, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than: 0}

  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :surpassed_reserve do
      transitions from: :published, to: :reserve_met
    end

    event :cancel do
      transitions from: :published, to: :cancelled
    end

  end
end
