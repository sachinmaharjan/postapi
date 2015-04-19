class Image < ActiveRecord::Base
  belongs_to :post
  
  validates :path, presence: true
  validates :post_id, presence: true
end
