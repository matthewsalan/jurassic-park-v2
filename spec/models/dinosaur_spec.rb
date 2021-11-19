require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  describe '#create' do
    context 'valid dinosaur' do
      let(:cage) { Cage.create }
      let(:dinosaur) { Dinosaur.create(name: 'Dino', cage: cage) }
      subject { dinosaur }

      it 'creates a dinosaur instance' do
        expect(subject.save).to eq true
      end

      it 'creates a dinosaur instance' do
        expect { subject.save }.to change { Dinosaur.count }.by 1
      end
    end

    context 'invlaid dinosaur' do
      context 'name required' do
        let(:cage) { Cage.create }
        let(:dinosaur) { Dinosaur.create(cage: cage) }
        subject { dinosaur }

        it 'doesn create a dinosaur instance' do
          expect(subject.save).to eq false
        end

        it 'does not change dinosaur instance' do
          expect { subject.save }.to_not change { Dinosaur.count }
        end
      end
    end
  end
end
