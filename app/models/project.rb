class Project < ApplicationRecord
  # geocoded_by :address, longitude: :lon, latitude: :lat
  # after_validation :geocode, if: :will_save_change_to_address?

  has_one_attached :photo
  has_many :questions, dependent: :destroy

  # validates : address
  validates :description, presence: true
  validates :title, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :progress, presence: true
end
