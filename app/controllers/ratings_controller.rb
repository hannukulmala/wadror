class RatingsController < ApplicationController
  before_action :expire_brewerylist_cache, only: [:update, :create, :delete]

  def index
    if !Rails.cache.exist?("users top 3")
      Rails.cache.write("users top 3", User.top(3), expires_in: 1.minutes)
    end

    if !Rails.cache.exist?("beers top 3")
      Rails.cache.write("beers top 3", Beer.top(3), expires_in: 1.minutes)
    end

    if !Rails.cache.exist?("styles top 3")
      Rails.cache.write("styles top 3", Style.top(3), expires_in: 1.minutes)
    end

    if !Rails.cache.exist?("breweries top 3")
      Rails.cache.write("breweries top 3", Brewery.top(3), expires_in: 1.minutes)
    end

    if !Rails.cache.exist?("recent ratings")
      Rails.cache.write("recent ratings", Rating.recent, expires_in: 1.minutes)
    end

    @recent_ratings = Rails.cache.read("recent ratings")
    @top_breweries = Rails.cache.read("breweries top 3")
    @top_styles = Rails.cache.read("styles top 3")
    @top_beers = Rails.cache.read("beers top 3")
    @top_users = Rails.cache.read("users top 3")
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
