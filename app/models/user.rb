class User < ApplicationRecord
  acts_as_token_authenticatable

  has_many :checkpoints
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
