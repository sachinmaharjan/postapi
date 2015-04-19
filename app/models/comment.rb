class Comment < ActiveRecord::Base
  acts_as_tree order: 'created_at DESC'
  default_scope -> { order('created_at DESC') }

  validates :message, presence: true
  validates :post_id, presence: true
  validates :user_id, presence: true

  belongs_to :post
end
