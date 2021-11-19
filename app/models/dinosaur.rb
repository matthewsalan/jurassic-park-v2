class Dinosaur < ApplicationRecord
  belongs_to :herbivore, optional: true
  belongs_to :carnivore, optional: true
end
