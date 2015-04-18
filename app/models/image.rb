class Image < ActiveRecord::Base

  validates :path, presence: true
  validates :post_id, presence: true
  belongs_to :post
end
