# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Grid, type: :model do
  it { is_expected.to have_many(:solutions) }

  subject { build(:grid) }

  describe 'with valid values' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe 'dimension attribute' do
    it { validate_presence_of(:dimension) }
    it { validate_numericality_of(:dimension) }

    context 'with an invalid value' do
      let(:grid) { build(:grid, dimension: 0) }

      it 'is invalid' do
        expect(grid).to_not be_valid
        grid.dimension = nil
        expect(grid).to_not be_valid
      end
    end
  end

  describe 'rows attribute' do
    it { validate_presence_of(:rows) }

    context 'with an invalid value' do
      let(:grid) { build(:grid, rows: '') }

      it 'is invalid' do
        expect(grid).to_not be_valid
        grid.rows = nil
        expect(grid).to_not be_valid
      end
    end
  end

  describe 'rows_equal_to_dimension validation' do
    context 'with different number of rows' do
      let(:grid) { build(:grid, rows: '111') }

      it 'is invalid' do
        expect(grid).to_not be_valid
      end
    end
  end

  describe 'validate_rows_format validation' do
    context 'with rows with invalid characters' do
      let(:grid) { build(:grid, rows: '123,abc,&*(') }

      it 'is invalid' do
        expect(grid).to_not be_valid
      end
    end

    context 'with rows with different number of characters' do
      let(:grid) { build(:grid, rows: '111111,0,11') }

      it 'is invalid' do
        expect(grid).to_not be_valid
      end
    end
  end
end
