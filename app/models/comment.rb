require 'dm-timestamps'

class Comment
  include DataMapper::Resource
  belongs_to :user
  belongs_to :item
  
  property :id, Serial
  property :item_id, Integer
  property :user_id, Integer
  property :text, String
  property :updated_at, DateTime
  property :created_at, DateTime

end
