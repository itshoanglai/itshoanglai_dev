class User < ApplicationRecord
  has_one :patient
  has_one :medical_staff
end
