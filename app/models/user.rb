class User < ApplicationRecord
  has_secure_password

  has_one :patient
  has_one :medical_staff

  validates: :email, presence: true, uniqueness: true
end
