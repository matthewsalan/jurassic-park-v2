class Cage < ApplicationRecord
  has_many :dinosaurs
  validates :species_type, presence: true
end
