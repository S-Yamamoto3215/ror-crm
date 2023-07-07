class Tag < ApplicationRecord
  has_many :classifications, dependent: :destroy
  has_many :posts, through: :classifications

  validates :name, presence: true, uniqueness: true
end
