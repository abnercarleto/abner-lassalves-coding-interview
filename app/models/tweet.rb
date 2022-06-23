class Tweet < ApplicationRecord
  belongs_to :user

  scope :most_recently, -> { order(created_at: :desc) }
  scope :by_user, ->(user) { where(user: user) }
end
