require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username: "Pekka", password: "Ap3", password_confirmation: "Ap3"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with password in all lower-case" do
    user = User.create username: "Pekka", password: "abcdefghijkl", password_confirmation: "abcdefghijkl"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating({ user: user }, 10 )
      create_beer_with_rating({ user: user }, 7 )
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest average rating if several rated" do
      #create_beers_with_many_ratings_and_style({ user: user }, *(20..25), "Lager" )
      #create_beers_with_many_ratings_and_style({ user: user }, *(30..35), "IPA" )
      #create_beers_with_many_ratings_and_style({ user: user }, *(35..40), "Weizen" )
      #best = create_beer_with_rating_and_style({ user: user }, 47, "Weizen" ) 
      #
      create_beers_with_many_ratings({ user: user, style: 'Lager' }, *(20..25) )
      create_beers_with_many_ratings({ user: user, style: 'IPA' }, *(30..35) )
      create_beers_with_many_ratings({ user: user, style: 'Weizen' }, *(35..40) )
      best = create_beer_with_rating({ user: user, style: 'Weizen' }, 47 ) 

      expect(user.favorite_style).to eq(best.style)
    end
  end

  def create_beer_with_rating(object, score)
    if not object[:style].nil?
      beer = FactoryBot.create(:beer, style: object[:style])
    else
      beer = FactoryBot.create(:beer)
    end
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
    end
  end
end
