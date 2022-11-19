class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def print_rating
    num_ratings = ratings.count
    "Beer has #{num_ratings} #{'rating'.pluralize(num_ratings)} with an average of #{average_rating}"
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
