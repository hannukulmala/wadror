class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user
  validates :name, presence: true

  def print_rating
    num_ratings = ratings.count
    "Beer has #{num_ratings} #{'rating'.pluralize(num_ratings)} with an average of #{average_rating}"
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
