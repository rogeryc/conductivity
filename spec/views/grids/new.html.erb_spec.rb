require 'rails_helper'

RSpec.describe "grids/new", type: :view do
  before(:each) do
    assign(:grid, Grid.new(
      outcome: "MyString",
      rows: "MyString",
      dimension: 1
    ))
  end

  it "renders new grid form" do
    render

    assert_select "form[action=?][method=?]", grids_path, "post" do

      assert_select "input[name=?]", "grid[outcome]"

      assert_select "input[name=?]", "grid[rows]"

      assert_select "input[name=?]", "grid[dimension]"
    end
  end
end
