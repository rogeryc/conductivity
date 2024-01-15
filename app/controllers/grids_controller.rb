# frozen_string_literal: true

class GridsController < ApplicationController
  before_action :set_grid, only: %i[show destroy]

  # GET /grids or /grids.json
  def index
    @grids = Grid.all
    @grid = Grid.new
  end

  # GET /grids/1 or /grids/1.json
  def show
    @rows = @grid.rows.split(',')
  end

  # GET /grids/new
  def new
    @grid = Grid.new
    new_grid = params[:grid]
    @grid.dimension = new_grid.present? ? new_grid[:dimension].to_i : 3
  end

  # GET /grids/new
  def random_new
    @grid = Grid.new
    new_grid = params[:grid]
    @grid.dimension = new_grid.present? ? new_grid[:dimension].to_i : 3
    @grid.rows = calculate_random_rows(@grid.dimension)
    render :new
  end

  # POST /grids or /grids.json
  def create
    @grid = Grid.new(grid_params)
    grid_creator = GridCreator.new(@grid)

    respond_to do |format|
      if (grid = grid_creator.call)
        format.html { redirect_to grid_url(grid), notice: 'Grid was successfully created.' }
        format.json { render :show, status: :created, location: grid }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: grid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grids/1 or /grids/1.json
  def destroy
    @grid.destroy!

    respond_to do |format|
      format.html { redirect_to grids_url, notice: 'Grid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /grids/import
  def import
    return redirect_to grids_url, notice: 'No file added' if params[:file].nil?
    return redirect_to grids_url, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    if (grid = CsvImport.new.call(params[:file]))
      redirect_to grid_url(grid), notice: 'Grid was successfully created.'
    else
      redirect_to grids_path, alert: 'Invalid CSV file.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_grid
    @grid = Grid.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def grid_params
    params.require(:grid).permit(:outcome, :rows, :dimension)
  end

  def calculate_random_rows(dimension)
    rows = ''
    (1..dimension).each do |_i|
      rows += ',' unless rows.empty?

      (1..dimension).each do |_j|
        rows += rand(2).to_s
      end
    end
    rows
  end
end
