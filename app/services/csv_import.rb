class CsvImport
  require 'csv'

  def call(csv_file)
    if csv_file.present? && csv_file.respond_to?(:tempfile)
      grid_data = parse_csv(csv_file.tempfile)

      if valid_grid?(grid_data)
        @grid = Grid.create(dimension: grid_data.split(',').size , rows: grid_data)
        
        grid_creator = GridCreator.new(@grid).call
        grid_creator
      end
    end
  end

  private

  def valid_grid?(grid_data)
    return false unless grid_data.is_a?(String) && !grid_data.empty?

    rows = grid_data.split(',')
    cols_size = rows.first.size
    rows.size == cols_size
  end

  def parse_csv(file)
    data = CSV.read(file, col_sep: ',', converters: :numeric)
    data.map { |row| row.join }.join(',')
  end
end