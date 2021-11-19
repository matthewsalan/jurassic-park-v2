require 'rails_helper'

RSpec.describe 'Dinosaurs', type: :request do
  describe '#show' do
    let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:dinosaur) { Dinosaur.create(carnivore: carnivore) }
    let(:cage) { Cage.create(species_type: 'Carnivore', status: 'ACTIVE', carnivores: [carnivore]) }
    let(:body) { JSON.parse(response.body) }

    it 'renders a json response' do
      cage
      dinosaur
      get dinosaur_path(carnivore.id), as: :json
      expect(body).to eq({ 'cage_id' => cage.id, 'id' => carnivore.id, 'name' => 'Trex', 'species' => 'Tyrannosaurus' })
    end

    it 'renders a successful status code' do
      cage
      dinosaur
      get dinosaur_path(carnivore.id), as: :json
      expect(response.status).to eq 200
    end

    context '404' do
      it 'returns a failed response code' do
        get dinosaur_path(1001), as: :json
        expect(response.status).to eq 404
      end

      it 'returns a error message' do
        get dinosaur_path(1001), as: :json
        expect(body['errors']).to eq "Couldn't find Dinosaur"
      end
    end
  end

  describe '#index' do
    let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:herbivore) { Herbivore.create(species: 'Stegosaurus', name: 'Steggy') }
    let(:dinosaur1) { Dinosaur.create(carnivore: carnivore) }
    let(:dinosaur2) { Dinosaur.create(herbivore: herbivore) }
    let(:cage1) { Cage.create(species_type: 'Carnivore', status: 'ACTIVE') }
    let(:cage2) { Cage.create(species_type: 'Herbivore', status: 'ACTIVE') }
    let(:body) { JSON.parse(response.body) }

    context 'when a filter is passed' do
      before { cage1.update(carnivores: [carnivore]) }

      it 'returns only dinosaurs belonging to a certain cage' do
        dinosaur1
        dinosaur2
        cage1
        cage2
        get dinosaurs_path(params: { filter_by: { cage_id: cage1.id } }), as: :json
        expect(body).to eq(
          [
            { 'cage_id' => cage1.id, 'id' => carnivore.id, 'name' => 'Trex', 'species' => 'Tyrannosaurus' }
          ]
        )
      end
    end

    context 'no cage id provided' do
      it 'returns a 404' do
        get dinosaurs_path, as: :json
        expect(response.status).to eq 404
      end

      it 'returns an empty json body' do
        get dinosaurs_path, as: :json
        expect(body['error']).to eq 'Must provide a cage_id'
      end
    end
  end
end
