class Herbivore < ApplicationRecord
  belongs_to :cage
  has_many :dinosaurs
  before_save :veryify_valid_species?, :verify_cage_species
  validates :name, presence: true
  accepts_nested_attributes_for :dinosaurs

  VALID_SPECIES = %w[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].freeze

  def veryify_valid_species?
    raise ActiveRecord::RecordInvalid unless VALID_SPECIES.include?(species)
  end

  def verify_cage_species
    raise MixedSpeciesError, 'Cage contains a different species' unless self.class.to_s == cage.species_type
  end

  class MixedSpeciesError < StandardError
  end
end
