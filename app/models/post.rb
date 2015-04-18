class Post < ActiveRecord::Base

  default_scope -> { order('created_at DESC') }

  validates :author, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :image
  has_many :comments
end
