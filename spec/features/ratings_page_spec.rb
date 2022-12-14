require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "list page shows recent ratings" do
    rating1 = FactoryBot.create(:rating, user: user)
    rating2 = FactoryBot.create(:rating, user: user, score: 20)
    rating3 = FactoryBot.create(:rating, user: user, score: 30)
    last_five = Rating.all.last(5)
    num_ratings = last_five.count
    visit ratings_path
    expect(page).to have_content "Recent ratings"
    last_five.each do |e|
      expect(page).to have_content e.to_s
    end

  end

  it "user page shows only ratings for that user" do
    rating1 = FactoryBot.create(:rating, user: user)
    rating2 = FactoryBot.create(:rating, user: user, score: 20)
    rating3 = FactoryBot.create(:rating, user: user, score: 30)

    visit user_path(user)
    user.ratings.each do |e|
      expect(page).to have_content e.to_s
    end
    # binding.pry
    expect(page).to have_selector('ul.ratings li', :count => user.ratings.count)
  end

  it "user can delete ratings from user page" do
    rating1 = FactoryBot.create(:rating, user: user)
    rating2 = FactoryBot.create(:rating, user: user, score: 20)
    rating3 = FactoryBot.create(:rating, user: user, score: 30)

    visit user_path(user)
    expect{
      first(:link, 'Delete').click
      first(:link, 'Delete').click
    }.to change{Rating.count}.from(3).to(1)

  end
end
