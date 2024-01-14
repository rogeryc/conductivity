class GridCreator
  def initialize(grid)
    @grid = grid
  end

  def create
    return false unless @grid.save

    calculate_paths(@grid)
    @grid
  end

  private

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

  def search_path(row, col, current_path) # rubocop:disable Metrics/AbcSize
    return if invalid_path?(@example, row, col, @visited)

    @visited[row][col] = true
    current_path.push([row, col])

    if row == @example.length - 1
      @paths.push(current_path.clone)
    else
      directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
      directions.each do |dir|
        new_row = row + dir[0]
        new_col = col + dir[1]
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
