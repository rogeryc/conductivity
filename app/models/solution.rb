# frozen_string_literal: true

class Solution < ApplicationRecord
  validates :number, presence: true
  validates :number, uniqueness: { scope: :grid_id }
  validates :number, numericality: { greater_than: 0 }

  belongs_to :grid
  has_many :steps, dependent: :destroy
end
