require 'dm-timestamps'

class Comment
  include DataMapper::Resource
  
  belongs_to :user
  belongs_to :item
  belongs_to :parent, :child_key => [:parent_id], :class_name => "Comment"
    
  property :id, Serial
  property :item_id, Integer
  property :user_id, Integer
  property :parent_id, Integer
  property :text, String
  property :updated_at, DateTime
  property :created_at, DateTime
  
  def formatted_text
    text.gsub(/\n/, '<br/>')
  end
  
  def children
    self.class.all :parent_id => self.id
  end

end
