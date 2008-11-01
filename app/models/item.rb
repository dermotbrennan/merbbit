require 'dm-timestamps'
require 'uri'

class Item
  include DataMapper::Resource
  belongs_to :user
  has n, :comments
  
  property :id, Serial
  property :title, String
  property :url, String
  property :user_id, Integer
  property :updated_at, DateTime
  property :created_at, DateTime
  
  def url_domain
    ::URI.parse(url).host
  end
end