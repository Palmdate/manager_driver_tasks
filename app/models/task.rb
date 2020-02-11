class Task < ApplicationRecord
  belongs_to :driver, optional: true
  validates :description, presence: true
  validates :pickup_loc, presence: true
  validates :deliver_loc, presence: true
end
