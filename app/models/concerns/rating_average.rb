module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    rating_count = ratings.size
    return 0 if rating_count == 0

    # ratings.average(:score).round(1)
    (ratings.map{ |r| r.score}.sum / rating_count).round(1)
  end
end
