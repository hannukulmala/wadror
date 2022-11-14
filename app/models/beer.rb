class Beer < ApplicationRecord
    include RatingAverage
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def print_rating
      num_ratings = self.ratings.count
      "Beer has #{num_ratings} #{'rating'.pluralize(num_ratings)} with an average of #{self.average_rating}"
    end
    
    def to_s
      "#{self.name}, #{self.brewery.name}"
    end
     
end
