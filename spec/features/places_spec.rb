require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several is returned by the API, they're shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), 
        Place.new( name: "Hamppubaari", id: 2 ),
        Place.new( name: "Esso", id: 3 )]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Hamppubaari"
    expect(page).to have_content "Esso"
  end

  it "if empty array is returned by the API, error message is shown" do
    searched_place = "kumpula"
    allow(BeermappingApi).to receive(:places_in).with(searched_place).and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in " + searched_place
  end
end
