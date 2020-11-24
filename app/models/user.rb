class User < ApplicationRecord
  has_many :checkpoints

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
