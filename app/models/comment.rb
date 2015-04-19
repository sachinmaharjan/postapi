class Comment < ActiveRecord::Base
  # attr_accessible :post_id, :user_id, :parent_id, :message, :deleted
  acts_as_tree order: 'created_at DESC'
  default_scope -> { order('created_at DESC') }

  validates :message, presence: true
  validates :post_id, presence: true
  validates :user_id, presence: true

  belongs_to :post
end
