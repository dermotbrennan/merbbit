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

  validates_present :user_id, :item_id, :value
  validates_with_method :check_hasnt_already_voted
  
  private
  def check_hasnt_already_voted
    !self.user.nil? &&
      !self.user.voted_for?(self.item)
  end

end
