class Cage < ApplicationRecord
  has_many :carnivores
  has_many :herbivores
  validates :species_type, presence: true
  accepts_nested_attributes_for :carnivores, :herbivores
  before_save :verify_species_match?

  def verify_species_match?
    ActiveRecord::Base.transaction do
      raise MixedSpeciesError, 'Cage contains dinosaur species' if carnivores.present? && herbivores.present?
    end
  end

  class MixedSpeciesError < StandardError
  end
end
