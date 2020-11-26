class User < ApplicationRecord
  has_many :checkpoints
  has_many :feedbacks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
