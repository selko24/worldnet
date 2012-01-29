class Post < ActiveRecord::Base
  attr_accessible :content, :title, :url
  
  belongs_to :user
  
  validates :content, :presence => true,
                      :length => {:within => 5..200}
  validates :url,     :presence => true,
                      :uniqueness => true
  validates :title, :presence => true
  
end
