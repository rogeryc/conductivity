# frozen_string_literal: true

class Step < ApplicationRecord
  validates :sequence, :row, :index, presence: true
  validates :sequence, uniqueness: { scope: :solution_id }
  validates :sequence, numericality: { greater_than: 0 }
  validates :row, :index, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :solution
end
