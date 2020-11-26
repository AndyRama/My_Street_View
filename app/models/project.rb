class Project < ApplicationRecord
  has_one_attached :photo
  has_many :questions, dependent: :destroy
  
  validates :description, presence: true
  validates :title, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :progress, presence: true
end
