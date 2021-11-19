require 'rails_helper'

RSpec.describe 'Cages', type: :request do
  describe '#show' do
    let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:cage) { Cage.create(species_type: 'Carnivore', status: 'ACTIVE', carnivores: [carnivore]) }
    let(:body) { JSON.parse(response.body) }

    it 'renders a json response' do
      cage
      get cage_path(cage.id), as: :json
      expect(body).to eq({ 'id' => cage.id, 'status' => 'ACTIVE', 'species_type' => 'Carnivore', 'current_capacity' => 1 })
    end

    it 'renders a successful status code' do
      cage
      get cage_path(cage.id), as: :json
      expect(response.status).to eq 200
    end

    context '404' do
      it 'returns a failed response code' do
        get cage_path(1001), as: :json
        expect(response.status).to eq 404
      end

      it 'returns a error message' do
        get cage_path(1001), as: :json
        expect(body['errors']).to eq "Couldn't find Cage with 'id'=1001"
      end
    end
  end

  describe '#index' do
    let(:carnivore) { Carnivore.create(species: 'Tyrannosaurus', name: 'Trex') }
    let(:cage1) { Cage.create(species_type: 'Carnivore', status: 'ACTIVE') }
    let(:cage2) { Cage.create(species_type: 'Carnivore', status: 'DOWN') }
    let(:body) { JSON.parse(response.body) }

    it 'returns a success code' do
      cage1
      cage2
      get cages_path, as: :json
      expect(response.status).to eq 200
    end

    context 'list of cages' do
      before { cage1.update(carnivores: [carnivore]) }

      it 'returns a json body containing a list of cages' do
        cage1
        cage2
        get cages_path, as: :json
        expect(body).to eq(
          [
            { 'capacity' => 10, 'current_capacity' => 1, 'id' => cage1.id, 'species_type' => 'Carnivore', 'status' => 'ACTIVE' },
            { 'capacity' => 10, 'current_capacity' => 0, 'id' => cage2.id, 'species_type' => 'Carnivore', 'status' => 'DOWN' }
          ]
        )
      end
    end

    context 'when a filter is passed' do
      before { cage1.update(carnivores: [carnivore]) }

      it 'returns active cages only' do
        cage1
        cage2
        get cages_path(params: { filter_by: { status: 'ACTIVE' } }), as: :json
        expect(body).to eq(
          [
            { 'capacity' => 10, 'current_capacity' => 1, 'id' => cage1.id, 'species_type' => 'Carnivore', 'status' => 'ACTIVE' }
          ]
        )
      end
    end

    context 'no cages' do
      it 'returns a 200' do
        get cages_path, as: :json
        expect(response.status).to eq 200
      end

      it 'returns an empty json body' do
        get cages_path, as: :json
        expect(body).to eq []
      end
    end
  end
end
