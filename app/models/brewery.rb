class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def print_report
      puts name
      puts "established at year #{year}"
      puts "number of beers #{beers.count}"
    end

    def print_rating
      res =  "Brewery has #{self.ratings.count} #{'rating'.pluralize(self.ratings.count)}"
      if self.ratings.count > 0
        res += " with an average of #{self.average_rating}" 
      end
      return res
    end
      
    def restart
      self.year = 2022
      puts "changed year to #{year}"
    end

    def average_rating
      self.ratings.average(:score)
    end

end
