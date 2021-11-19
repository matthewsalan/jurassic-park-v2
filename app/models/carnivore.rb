class Carnivore < ApplicationRecord
  belongs_to :dinosaur
  before_save :veryify_valid_species?
  accepts_nested_attributes_for :dinosaur

  VALID_SPECIES = %w[Tyrannosaurus Velociraptor Spinosaurus Megalosaurus].freeze

  def veryify_valid_species?
    raise ActiveRecord::RecordInvalid unless VALID_SPECIES.include?(species)
  end
end
