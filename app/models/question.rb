class Question < ApplicationRecord
  belongs_to :project
<<<<<<< HEAD
  has_many :feedbacks
=======
  has_many :feedbacks, dependent: :destroy
>>>>>>> 8d3387d7c2a61acc3ac7ff2e6ecec5c9293f10bd

  validates :title, presence: true
  validates :first_answer, presence: true
  validates :second_answer, presence: true
end
