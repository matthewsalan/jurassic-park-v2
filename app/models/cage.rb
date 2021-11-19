class Cage < ApplicationRecord
  has_many :carnivores
  has_many :herbivores
  validates :species_type, presence: true
  accepts_nested_attributes_for :carnivores, :herbivores
  before_save :verify_species_match?
  before_update :verify_cage_status

  def verify_species_match?
    ActiveRecord::Base.transaction do
      raise MixedSpeciesError, 'Cage contains dinosaur species' if carnivores.present? && herbivores.present?
    end
  end

  def verify_cage_status
    ActiveRecord::Base.transaction do
      if changed_attributes['status'] == 'ACTIVE' && (carnivores.present? || herbivores.present?)
        raise CageStatusError, 'Cannot power down cage with dinosaurs in it'
      end
    end
  end

  class MixedSpeciesError < StandardError
  end

  class CageStatusError < StandardError
  end
end
