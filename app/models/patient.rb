# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :user, optional: true
end
