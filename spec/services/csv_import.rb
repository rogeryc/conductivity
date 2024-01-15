require 'rails_helper'
require 'csv'

RSpec.describe CsvImport, type: :service do
  describe '#call' do
    let(:grid) { call(:grid) }

    let(:data) do
      CSV.generate do |csv|
        csv << %w[1 1 1 0]
        csv << %w[1 0 0 1]
        csv << %w[0 0 1 1]
        csv << %w[1 1 1 1]
      end
    end

    let(:file_path) { 'spec/fixtures/csv_example.csv' }
    let!(:csv) do
      CSV.open(file_path, 'w') do |csv|
        rows.each do |row|
          csv << row.split(',')
        end
      end
    end

    it 'creates the grid from a valid CSV' do
      expect do
        GridCreator.new(grid).create
      end.to change(Solution, :count).by(3)
    end
  end
end
