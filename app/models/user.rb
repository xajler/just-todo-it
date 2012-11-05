class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :full_name
  attr_readonly :email

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                      message: 'The format of Email is invalid'}
  validates :password, presence: true, length: { minimum: 8 }
  validates :full_name, presence: true
end
