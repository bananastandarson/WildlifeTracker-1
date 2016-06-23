class Sighting < ActiveRecord::Base
  belongs_to :animal
  belongs_to :region
  validates :animal, presence: true
  validates :region, presence: true
end
