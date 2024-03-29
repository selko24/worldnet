class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :posts
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\-[a-z]+\z/i
  
  validates :name, :presence => true,
                    :length => { :within => 6..30}
  
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  validates :password, :presence => true,
                       :length => { :within => 6..30 },
                       :confirmation => true

  before_save :encrypt_password
  
  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end
  
  def formatted_email
    "#{@name} <#{@email}>"
  end
  
  def self.authenticate(email, pass)
    user = find_by_email(email)
    if user.nil?
      nil
    else
      if user.encrypted_password == encrypt(pass)
      user
      else
        nil
      end
    end
  end

def has_password?(submitted_password)
  encrypted_password == encrypt(submitted_password)
end

class << self

def authenticate(email, submitted_password)
  user = find_by_email(email)
  return nil if user.nil?
  return user if user.has_password?(submitted_password)
end
end
  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
end
