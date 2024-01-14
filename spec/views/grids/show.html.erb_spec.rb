require 'rails_helper'

RSpec.describe "grids/show", type: :view do
  before(:each) do
    assign(:grid, Grid.create!(
      outcome: "Outcome",
      rows: "Rows",
      dimension: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Outcome/)
    expect(rendered).to match(/Rows/)
    expect(rendered).to match(/2/)
  end
end
