class Herbivore < ApplicationRecord
  belongs_to :dinosaur

  VALID_SPECIES = %w[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].freeze
end
