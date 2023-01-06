class Character < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 24}
end
