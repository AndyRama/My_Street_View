class Project < ApplicationRecord
  validates :description, presence: true
  validates :title, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :progress, presence: true
end
