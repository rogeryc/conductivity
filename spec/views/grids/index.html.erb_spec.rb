require 'rails_helper'

RSpec.describe "grids/index", type: :view do
  before(:each) do
    assign(:grids, [
      Grid.create!(
        outcome: "Outcome",
        rows: "Rows",
        dimension: 2
      ),
      Grid.create!(
        outcome: "Outcome",
        rows: "Rows",
        dimension: 2
      )
    ])
  end

  it "renders a list of grids" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Outcome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Rows".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
