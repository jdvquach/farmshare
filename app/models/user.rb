class User < ApplicationRecord

  has_secure_password   # makes 'password' field MANDATORY
  validates :email, presence: true, uniqueness: true
  has_many :items
  before_save { self.email = email.downcase }
  
end
