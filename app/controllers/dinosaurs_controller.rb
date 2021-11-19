class DinosaursController < ApplicationController
  before_action :find_dinosaur, only: [:show]
  before_action :find_dinosaurs, only: [:index]

  def show
    @dinosaur
  end

  def index
    @dinosaurs
  end

  private

  def find_dinosaur
    dinosaur = Dinosaur.find_by!(carnivore_id: dinosaur_params[:id])
    dinosaur ||= Dinosaur.find_by!(herbivore_id: dinosaur_params[:id]) unless dinosaur
    @dinosaur = dinosaur.carnivore || dinosaur.herbivore
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e }, status: 404
  end

  def find_dinosaurs
    render json: { error: 'Must provide a cage_id' }, status: 404 and return unless dinosaur_params[:filter_by].present?
    @dinosaurs = Carnivore.where(cage_id: dinosaur_params[:filter_by][:cage_id]) || Herbivore.where(cage_id: dinosaur_params[:filter_by][:cage_id])
  end

  def dinosaur_params
    params.permit(:id, filter_by: [:cage_id])
  end
end
