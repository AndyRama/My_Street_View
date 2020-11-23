class Checkpoint < ApplicationRecord
  belongs_to :user

  validates :longitude, presence: true
  validates :latitude, presence: true
end
