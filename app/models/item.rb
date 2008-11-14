require 'dm-timestamps'
require 'uri'

class Item
  include DataMapper::Resource
  belongs_to :user
  has n, :comments
  has n, :votes
  
  property :id, Serial
  property :title, String
  property :url, String
  property :user_id, Integer
  property :updated_at, DateTime
  property :created_at, DateTime
  
  def url_domain
    ::URI.parse(url).host || url
  end
  
  def votes_count
    votes.map {|v| v.value}.compact.inject(0) {|i,j| i+j}
  end
  
  def root_comments
    @comments ||= comments
    @comments.select {|comment| comment.parent_id.nil? }.sort_by {|comment_a| comment_a.created_at }
  end
end
