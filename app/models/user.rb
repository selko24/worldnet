class User < ActiveRecord::Base
  attr_accessor :password, :name, :email
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :posts
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\-[a-z]+\z/i
  
  validates :name, :presence => true,
                    :length => { :within => 6..30}
  
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  validates :password, :presence => true,
                       :length => { :within => 6..40 },
                       :confirmation => true

  before_save :convert_password
  
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
      if user.hash_password == encrypt(pass)
      user
      else
        nil
      end
    end
  end

  private
  def convert_password
    self.hash_password = encrypt(password)
  end

  def self.encrypt(string)
    Digest::SHA2.hexdigest(string)
  end
  def encrypt(string)
    Digest::SHA2.hexdigest(string)
  end
end
