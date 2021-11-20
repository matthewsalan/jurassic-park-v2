class DinosaursController < ApplicationController
  before_action :find_dinosaur, only: [:show, :update]
  before_action :find_dinosaurs, only: [:index]

  def show
    @dinosaur
  end

  def index
    @dinosaurs
  end

  def create
    klass = dinosaur_params[:species_type].constantize
    cage = Cage.create!(cage_params) if dinosaur_params[:with_cage]
    @dinosaur = klass.create!(create_params.merge(cage_id: cage&.id || dinosaur_params[:cage_id], dinosaurs: [Dinosaur.new]))

    render template: 'dinosaurs/create', status: 201
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e }, status: 404
  rescue StandardError => e
    render json: { errors: e.message }, status: 404
  end

  def update
    @dinosaur.update!(dinosaur_params)
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e }, status: 404
  rescue StandardError => e
    render json: { errors: e.message }, status: 404
  end

  private

  def find_dinosaur
    dinosaur = Dinosaur.find_by!(carnivore_id: dinosaur_params[:id])
    dinosaur ||= Dinosaur.find_by!(herbivore_id: dinosaur_params[:id]) unless dinosaur
    @dinosaur = dinosaur.carnivore || dinosaur.herbivore
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: 404
  end

  def find_dinosaurs
    render json: { error: 'Must provide a cage_id' }, status: 404 and return unless dinosaur_params[:filter_by].present?
    @dinosaurs = Carnivore.where(cage_id: dinosaur_params[:filter_by][:cage_id]) || Herbivore.where(cage_id: dinosaur_params[:filter_by][:cage_id])
  end

  def dinosaur_params
    params.permit(:id, :species, :name, :species_type, :cage_id, :with_cage, :cage_status, filter_by: [:cage_id])
  end

  def create_params
    { species: dinosaur_params[:species], name: dinosaur_params[:name] }
  end

  def cage_params
    { status: dinosaur_params[:cage_status], species_type: dinosaur_params[:species_type] }
  end
end
