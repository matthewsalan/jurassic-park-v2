class Carnivore < ApplicationRecord
  belongs_to :dinosaur

  VALID_SPECIES = %w[Tyrannosaurus Velociraptor Spinosaurus Megalosaurus].freeze
end
