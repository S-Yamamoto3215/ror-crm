class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 5..50 }
  validates :body, presence: true, length: { minimum: 10 }
end
