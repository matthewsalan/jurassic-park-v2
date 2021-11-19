class CagesController < ApplicationController
  before_action :find_cage, only: [:show, :update]
  before_action :find_cages, only: [:index]

  def show
    @cage
  end

  def index
    @cages
  end

  def create
    @cage = Cage.create!(create_params)
    render template: 'cages/create', status: 201
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e }, status: 404
  end

  def update
    @cage.update!(cage_params)
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e }, status: 404
  end

  private

  def find_cage
    @cage = Cage.find(cage_params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e }, status: 404
  end

  def find_cages
    @cages = cage_params[:filter_by].present? ? Cage.send(cage_params[:filter_by][:status].to_sym.downcase) : Cage.all
  end

  def cage_params
    params.permit(:id, :species_type, :status, filter_by: [:status])
  end

  def create_params
    { species_type: cage_params[:species_type], status: cage_params[:status] }
  end
end
