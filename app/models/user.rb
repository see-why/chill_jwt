class User < ApplicationRecord
  has_secure_password

  validates :emmail, presence: true, uniqueness: true
end
