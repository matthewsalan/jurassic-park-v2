class Herbivore < ApplicationRecord
  belongs_to :cage
  before_save :veryify_valid_species?
  validates :name, presence: true

  VALID_SPECIES = %w[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].freeze

  def veryify_valid_species?
    raise ActiveRecord::RecordInvalid unless VALID_SPECIES.include?(species)
  end
end
