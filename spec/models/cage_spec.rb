require 'rails_helper'

RSpec.describe Cage, type: :model do
  describe '#create' do
    let(:cage) { Cage.create(species_type: 'Carnivore') }
    subject { cage }

    it 'creates an instance of a cage' do
      expect { subject }.to change { Cage.count }.by 1
    end

    context 'species_type validation' do
      let(:cage) { Cage.create }
      subject { cage }

      it 'rolls back if not provided' do
        expect { subject }.to_not change { Cage.count }
      end
    end
  end

  describe 'species logic' do
    let(:cage) { Cage.create(species_type: 'Carnivore') }

    context 'carnivores' do
      it 'creates a cage with only carnivores' do
      end
    end
  end
end
