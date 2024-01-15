# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Step, type: :model do
  it { is_expected.to belong_to(:solution) }

  subject { build(:step) }

  describe 'with valid values' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe 'sequence attribute' do
    it { validate_presence_of(:sequence) }
    it { validate_uniqueness_of(:sequence) }
    it { validate_numericality_of(:sequence) }

    context 'with an invalid value' do
      let(:step) { build(:step, sequence: -1) }

      it 'is invalid' do
        expect(step).to_not be_valid
        step.sequence = nil
        expect(step).to_not be_valid
      end
    end

    context 'when sequence is not unique' do
      let(:solution) { build(:solution) }
      before { create(:step, solution: solution, sequence: 1) }
      let(:step2) { build(:step, solution: solution, sequence: 1) }

      it 'is invalid' do
        expect(step2).to_not be_valid
        expect(step2.errors[:sequence]).to eq ['has already been taken']
      end
    end
  end

  describe 'row attribute' do
    it { validate_presence_of(:row) }
    it { validate_numericality_of(:row) }

    context 'with an invalid value' do
      let(:step) { build(:step, row: -1) }

      it 'is invalid' do
        expect(step).to_not be_valid
        step.row = nil
        expect(step).to_not be_valid
      end
    end
  end

  describe 'index attribute' do
    it { validate_presence_of(:index) }
    it { validate_numericality_of(:index) }

    context 'with an invalid value' do
      let(:step) { build(:step, index: -1) }

      it 'is invalid' do
        expect(step).to_not be_valid
        step.index = nil
        expect(step).to_not be_valid
      end
    end
  end
end
