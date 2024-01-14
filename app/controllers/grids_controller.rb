class GridsController < ApplicationController
  before_action :set_grid, only: %i[ show destroy ]

  # GET /grids or /grids.json
  def index
    @grids = Grid.all
    @grid = Grid.new
  end

  # GET /grids/1 or /grids/1.json
  def show; end

  # GET /grids/new
  def new
    @grid = Grid.new
    new_grid = params[:grid]
    @grid.dimension = new_grid.present? ? new_grid[:dimension].to_i : 3
  end

  # POST /grids or /grids.json
  def create
    @grid = Grid.new(grid_params)

    respond_to do |format|
      if @grid.save
        calculate_paths(@grid)
        format.html { redirect_to grid_url(@grid), notice: "Grid was successfully created." }
        format.json { render :show, status: :created, location: @grid }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grids/1 or /grids/1.json
  def destroy
    @grid.destroy!

    respond_to do |format|
      format.html { redirect_to grids_url, notice: "Grid was successfully destroyed." }
      format.json { head :no_content }
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

  def calculate_paths(grid)
    @example = rows_to_array(grid.rows)

    @paths = []
    @visited = Array.new(grid.dimension) { Array.new(grid.dimension, false) }

    @example[0].each_with_index do |cell, index|
      next unless cell == 1

      search_path(0, index, [])
    end

    return unless @paths.any?

    save_solutions_from_path(@paths)
  end

  def search_path(row, col, current_path) 
    return if invalid_path?(@example, row, col, @visited)

    @visited[row][col] = true
    current_path.push([row, col])

    if row == @example.length - 1
      @paths.push(current_path.clone)
    else
      directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
      directions.each do |dir|
        new_row, new_col = row + dir[0], col + dir[1]
        search_path(new_row, new_col, current_path)
      end
    end

    @visited[row][col] = false
    current_path.pop
  end

  def invalid_path?(example, row, col, visited)
    return true if row.negative? || row >= example.length || col.negative? || col >= example[0].length

    true if (example[row][col]).zero? || visited[row][col]
  end

  def save_solutions_from_path(paths)
    paths.each_with_index do |path, i|
      solution = @grid.solutions.create(number: i + 1)
      path.each_with_index do |step, i|
        solution.steps.create(sequence: i + 1, row: step[0], index: step[1])
      end
    end
  end

  def rows_to_array(rows)
    rows.split(',').map { |row| row.chars.map(&:to_i) }
  end
end
