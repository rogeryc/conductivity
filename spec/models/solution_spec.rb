# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Solution, type: :model do
  it { is_expected.to have_many(:steps) }
  it { is_expected.to belong_to(:grid) }

  subject { build(:solution) }

  describe 'with valid values' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe 'number attribute' do
    it { validate_presence_of(:number) }
    it { validate_uniqueness_of(:number) }
    it { validate_numericality_of(:number) }

    context 'with an invalid value' do
      let(:solution) { build(:solution, number: 0) }

      it 'is invalid' do
        expect(solution).to_not be_valid
        solution.number = nil
        expect(solution).to_not be_valid
      end
    end
  end
end
