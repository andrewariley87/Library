require 'bcrypt'

class User < ApplicationRecord

  validates :first_name,
            :last_name,
            :email,
            presence: true

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end
end
