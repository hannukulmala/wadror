class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
      #self.ratings.average(:score).to_f
      sum = self.ratings.reduce (0) {|sum,element| sum + element.score}
      count = self.ratings.count
      (sum / count).to_f
    end

    def print_rating
      num_ratings = self.ratings.count
      "Beer has #{num_ratings} #{'rating'.pluralize(num_ratings)} with an average of #{self.average_rating}"
    end
    
    def to_s
      "#{self.name}, #{self.brewery.name}"
    end
     
end
