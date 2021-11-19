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
    let(:carnivore1) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:carnivore2) { Carnivore.create(species: 'Velociraptor', name: 'Raptor') }
    let(:herbivore1) { Herbivore.create(species: 'Stegosaurus', name: 'Steggy') }

    context 'carnivores' do
      let(:cage) { Cage.create(species_type: 'Carnivore', carnivores: [carnivore1, carnivore2]) }

      it 'creates a cage with some dinosaurs in it' do
        carnivore1
        carnivore2
        expect(cage.reload.carnivores.count).to eq 2
      end

      context 'same species' do
        let(:cage) { Cage.create(species_type: 'Carnivore', carnivores: [carnivore1, carnivore2], herbivores: [herbivore1]) }

        it 'creates a cage with only carnivores' do
          carnivore1
          carnivore2
          herbivore1
          expect { cage }.to raise_error
        end

        it 'returns an error message' do
          carnivore1
          carnivore2
          herbivore1
          expect { cage }.to raise_error('Cage contains dinosaur species')
        end
      end
    end
  end
end
