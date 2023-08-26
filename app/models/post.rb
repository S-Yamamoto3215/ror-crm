class Post < ApplicationRecord
  has_many :classifications, dependent: :destroy
  has_many :tags, through: :classifications
  belongs_to :user

  validates :title, presence: true, length: { in: 5..50 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :slug, presence: true, uniqueness: true
  validates :user_id, presence: true

  attr_accessor :tag_names

  before_save :assign_tags_from_names

  def assign_tags_from_names
    return if tag_names.blank?

    self.tags = tag_names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def tag_name_list
    self.tags.map(&:name).join(', ')
  end
end
