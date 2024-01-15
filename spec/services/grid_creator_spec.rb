# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GridCreator, type: :service do
  describe '#create' do
    let(:grid) { create(:grid) }

    it 'creates the expected solutions' do
      expect do
        GridCreator.new(grid).create
      end.to change(Solution, :count).by(3)
    end
  end
end
