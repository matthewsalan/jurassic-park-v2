class Herbivore < ApplicationRecord
  belongs_to :cage
  has_many :dinosaurs
  before_save :veryify_valid_species?
  validates :name, presence: true
  accepts_nested_attributes_for :dinosaurs

  VALID_SPECIES = %w[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].freeze

  def veryify_valid_species?
    raise ActiveRecord::RecordInvalid unless VALID_SPECIES.include?(species)
  end
end
