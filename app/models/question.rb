class Question < ApplicationRecord
  belongs_to :project
  has_many :feedbacks, dependent: :destroy
  has_many :questions, through: :project

  validates :title, presence: true
  validates :first_answer, presence: true
  validates :second_answer, presence: true
end

