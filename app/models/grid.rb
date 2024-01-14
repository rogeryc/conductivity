class Grid < ApplicationRecord
  validates :rows, presence: true
  validates :dimension, presence: true
  validates :dimension, numericality: { greater_than: 1 }
  
  # custom validations
  validate :rows_equal_to_dimension
  validate :validate_rows_format

  has_many :solutions, dependent: :destroy
  
  private 

  def rows_equal_to_dimension
    return if rows.blank? || dimension.blank?

    rows_array = rows.split(',')
    errors.add(:rows, "must have #{dimension} rows") unless rows_array.length == dimension
  end

  def validate_rows_format
    return if rows.blank? || dimension.blank?

    regex_pattern = /\A(?:[01]{#{dimension}},)+[01]{#{dimension}}\z/

    unless rows =~ regex_pattern
      errors.add(:rows, "must have #{dimension} digits of 0 or 1 and separated by comma.")
    end
  end
end
