class Post < ApplicationRecord
  has_many :classifications, dependent: :destroy
  has_many :tags, through: :classifications

  validates :title, presence: true, length: { in: 5..50 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :slug, presence: true, uniqueness: true
end
