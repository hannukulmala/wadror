require 'rails_helper'

include Helpers

describe "New beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style) { FactoryBot.create :style, name: "IPA" }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "is added when given non-empty name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'a')
    select(style.name, from: 'beer[style_id]')
    select(brewery.name, from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is not added with an empty name and error message is shown" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select(style.name, from: 'beer[style_id]')
    select(brewery.name, from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.not_to change{Beer.count}
    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"

  end
  

end
