class User < ApplicationRecord
  acts_as_token_authenticatable

  has_many :checkpoints
  has_many :feedbacks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
