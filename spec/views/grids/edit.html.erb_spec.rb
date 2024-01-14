require 'rails_helper'

RSpec.describe "grids/edit", type: :view do
  let(:grid) {
    Grid.create!(
      outcome: "MyString",
      rows: "MyString",
      dimension: 1
    )
  }

  before(:each) do
    assign(:grid, grid)
  end

  it "renders the edit grid form" do
    render

    assert_select "form[action=?][method=?]", grid_path(grid), "post" do

      assert_select "input[name=?]", "grid[outcome]"

      assert_select "input[name=?]", "grid[rows]"

      assert_select "input[name=?]", "grid[dimension]"
    end
  end
end
