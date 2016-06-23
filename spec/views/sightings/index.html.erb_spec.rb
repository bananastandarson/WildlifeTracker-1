require 'rails_helper'

RSpec.describe "sightings/index", type: :view do
  before(:each) do
    assign(:sightings, [
      Sighting.create!(
        :latitude => 1,
        :longitude => 2,
        :animal => nil,
        :region => nil
      ),
      Sighting.create!(
        :latitude => 1,
        :longitude => 2,
        :animal => nil,
        :region => nil
      )
    ])
  end

  it "renders a list of sightings" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
