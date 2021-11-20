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
    let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:herbivore) { Herbivore.create(species: 'Stegosaurus', name: 'Steggy') }

    context 'carnivores' do
      let(:cage) { Cage.create(species_type: 'Carnivore', carnivores: [carnivore]) }

      it 'creates a cage with some dinosaurs in it' do
        carnivore
        expect(cage.reload.carnivores.count).to eq 1
      end

      context 'same species' do
        let(:cage) { Cage.create(species_type: 'Carnivore', carnivores: [carnivore], herbivores: [herbivore]) }

        it 'creates a cage with only carnivores' do
          carnivore
          herbivore
          expect { cage }.to raise_error
        end

        it 'returns an error message' do
          carnivore
          herbivore
          expect { cage }.to raise_error('Cage contains different dinosaur species')
        end
      end
    end
  end

  describe 'cage status' do
    context 'powering off a cage with dinosaurs in it' do
      let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
      let(:cage) { Cage.create(species_type: 'Carnivore', status: 'ACTIVE', carnivores: [carnivore]) }

      it 'returns an error' do
        cage
        expect { cage.update(status: 'DOWN') }.to raise_error('Cannot power down cage with dinosaurs in it')
      end
    end
  end

  describe '#capacity' do
    let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:cage) { Cage.create(species_type: 'Carnivore', status: 'ACTIVE', carnivores: [carnivore]) }

    it 'returns the number of dinosaurs in the cage' do
      expect(cage.current_capacity).to eq 1
    end

    context 'max capacity' do
      before { allow(cage).to receive(:current_capacity).and_return(10) }

      it "doesn't allow adding more than 10 dinosaurs to a cage" do
        expect { cage.update(carnivores: [carnivore]) }.to raise_error('Exceeds number of dinosaurs allowed per cage')
      end
    end
  end
end
