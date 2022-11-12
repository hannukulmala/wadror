class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
      #self.ratings.average(:score).to_f
      sum = self.ratings.reduce (0) {|sum,element| sum + element.score}
      count = self.ratings.count
      (sum / count).to_f
    end

    def print_rating
      num_ratings = self.ratings.count
      if num_ratings == 1
        "Beer has #{self.ratings.count} rating with a score of #{self.average_rating}"
      else 
        "Beer has #{self.ratings.count} ratings with an average of #{self.average_rating}"
      end
    end
     
end
