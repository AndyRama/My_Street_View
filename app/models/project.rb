class Project < ApplicationRecord
  has_one_attached :photo
  has_many :questions, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :description, presence: true
  validates :title, presence: true
  # validates :longitude, presence: true
  # validates :latitude, presence: true
  validates :progress, presence: true
  validates :address, presence: true

end
