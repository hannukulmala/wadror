require 'rails_helper'

include Helpers

describe "User" do
  let!(:user){FactoryBot.create :user}
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end
  it "page shows user's favorite style" do
    rating1 = FactoryBot.create(:rating, user: user)
    rating2 = FactoryBot.create(:rating, user: user, score: 20)
    rating3 = FactoryBot.create(:rating, user: user, score: 30)
    
    visit user_path(user)
    expect(page).to have_content "Favorite style: #{user.favorite_style}"
  end

  it "page shows user's favorite brewery" do
    rating1 = FactoryBot.create(:rating, user: user)
    rating2 = FactoryBot.create(:rating, user: user, score: 20)
    rating3 = FactoryBot.create(:rating, user: user, score: 30)
    
    visit user_path(user)
    expect(page).to have_content "Favorite brewery: #{user.favorite_brewery.name}"
  end
end
