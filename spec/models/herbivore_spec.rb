require 'rails_helper'

RSpec.describe Herbivore, type: :model do
  describe '#create' do
    context 'valid dinosaur' do
      let(:cage) { Cage.create }
      subject { described_class.new(cage: cage, species: 'Stegosaurus', name: 'Dino') }

      it 'creates a herbivore instance' do
        expect(subject.save).to eq true
      end

      it 'creates a herbivore instance' do
        expect { subject.save }.to change { Herbivore.count }.by 1
      end
    end

    context 'invlaid dinosaur' do
      context 'name required' do
        let(:cage) { Cage.create }
        let(:dinosaur) { Dinosaur.create(cage: cage) }
        subject { described_class.new(cage: cage, species: 'Stegosaurus') }

        it 'doesn create a herbivore instance' do
          expect(subject.save).to eq false
        end

        it 'does not change herbivore instance' do
          expect { subject.save }.to_not change { Herbivore.count }
        end
      end

      context 'invalid species' do
        let(:cage) { Cage.create }
        subject { described_class.new(cage: cage, species: 'Velociraptor', name: 'Dino') }

        it 'doesn create a herbivore instance' do
          expect(subject.save).to eq false
        end

        it 'does not change herbivore instance' do
          expect { subject.save }.to_not change { Herbivore.count }
        end
      end
    end
  end
end
