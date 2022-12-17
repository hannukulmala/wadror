class Style < ApplicationRecord
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def self.top(count)
    Style.all.sort_by{ |b| -b.average_rating }.first(count)
  end
end
