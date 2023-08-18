class Genre < ApplicationRecord
  has_many :classifications, dependent: :destroy
  has_many :movies, through: :classifications

  validates :name, presence: true, uniqueness: true
end
