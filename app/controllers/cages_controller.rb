class CagesController < ApplicationController
  before_action :find_cage, only: [:show]
  before_action :find_cages, only: [:index]

  def show
    @cage
  end

  def index
    @cages
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
    params.permit(:id, filter_by: [:status])
  end
end
