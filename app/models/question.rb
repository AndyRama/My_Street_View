class Question < ApplicationRecord
  belongs_to :project
  has_one :feedback

  validates :title, presence: true
  validates :first_answer, presence: true
  validates :second_answer, presence: true
end
