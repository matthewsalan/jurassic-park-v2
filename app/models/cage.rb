class Cage < ApplicationRecord
  has_many :carnivores
  has_many :herbivores
  validates :species_type, presence: true
  accepts_nested_attributes_for :carnivores, :herbivores
  before_save :verify_species_match?, :verify_capacity
  before_update :verify_cage_status

  scope :active, -> { where(status: 'ACTIVE') }
  scope :down, -> { where(status: 'DOWN') }

  def verify_species_match?
    raise MixedSpeciesError, 'Cage contains dinosaur species' if carnivores.present? && herbivores.present?
  end

  def verify_cage_status
    if changed_attributes['status'] == 'ACTIVE' && (carnivores.present? || herbivores.present?)
      raise CageStatusError, 'Cannot power down cage with dinosaurs in it'
    end
  end

  def verify_capacity
    raise CageCapacityLimit, 'Exceeds number of dinosaurs allowed per cage' if current_capacity == 10
  end

  def current_capacity
    carnivores.present? ? carnivores.count : herbivores.count
  end

  class MixedSpeciesError < StandardError
  end

  class CageStatusError < StandardError
  end

  class CageCapacityLimit < StandardError
  end
end
