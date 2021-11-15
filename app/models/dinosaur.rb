class Dinosaur < ApplicationRecord
  belongs_to :cage
  has_many :herbivores
  has_many :carnivores

  validates :name, presence: true
end
