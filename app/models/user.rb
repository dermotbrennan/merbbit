# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see merb/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
require 'dm-timestamps'

class User
  include DataMapper::Resource
  
  has n, :items
  has n, :comments
  has n, :votes
  
  property :id,     Serial
  property :login,  String
  property :email, String
  property :crypted_password, String, :length => 150
  property :salt, String
  property :active, Boolean, :default => false
  property :updated_at, DateTime
  property :created_at, DateTime
  
  validates_present   :login, :email
  validates_is_unique :login, :email
  validates_format    :email, :as => :email_address

  attr_accessor :password, :password_confirmation
  validates_is_confirmed :password

  before :save, :encrypt_password

  def active?
    !!self.active
  end

  def self.encrypt(salt, password = nil)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def self.authenticate(login, password)
    u = self.first(:login => login)
    return nil unless u
    u.crypted_password == encrypt(u.salt, password) ? u : nil
  end

  def encrypt_password
    self.salt ||= Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--")
    self.crypted_password ||= User.encrypt(salt, password)
  end
  
  def voted_for?(item)
    return false unless item.class.respond_to? :id
    !Vote.all(:conditions => {:item_id => item.id, :user_id => id}).empty?
  end
end
