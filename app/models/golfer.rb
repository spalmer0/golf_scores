class Golfer < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
