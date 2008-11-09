require 'dm-timestamps'
class Vote
  include DataMapper::Resource
  belongs_to :user
  belongs_to :item
  
  property :id, Serial
  property :user_id, Integer
  property :item_id, Integer
  property :value, Integer
  property :updated_at, DateTime
  property :created_at, DateTime

end
