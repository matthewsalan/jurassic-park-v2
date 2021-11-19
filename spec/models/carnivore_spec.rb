require 'rails_helper'

RSpec.describe Carnivore, type: :model do
  describe '#create' do
    context 'valid dinosaur' do
      let(:cage) { Cage.create }
      let(:dinosaur) { Dinosaur.create(name: 'Dino', cage: cage) }
      subject { described_class.new(dinosaur: dinosaur, species: 'Velociraptor') }

      it 'creates a carnivore instance' do
        expect(subject.save).to eq true
      end

      it 'creates a carnivore instance' do
        expect { subject.save }.to change { Carnivore.count }.by 1
      end
    end

    context 'invlaid dinosaur' do
      context 'name required' do
        let(:cage) { Cage.create }
        let(:dinosaur) { Dinosaur.create(cage: cage) }
        subject { described_class.new(dinosaur: dinosaur, species: 'Velociraptor') }

        it 'doesn create a carnivore instance' do
          expect(subject.save).to eq false
        end

        it 'does not change carnivore instance' do
          expect { subject.save }.to_not change { Carnivore.count }
        end
      end

      context 'invalid species' do
        let(:cage) { Cage.create }
        let(:dinosaur) { Dinosaur.create(name: 'Dino', cage: cage) }
        subject { described_class.new(dinosaur: dinosaur, species: 'Stegosaurus') }

        it 'doesn create a carnivore instance' do
          expect(subject.save).to eq false
        end

        it 'does not change carnivore instance' do
          expect { subject.save }.to_not change { Carnivore.count }
        end
      end
    end
  end
end
