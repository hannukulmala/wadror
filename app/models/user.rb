class User < ApplicationRecord
  include RatingAverage
  has_secure_password
  PASSWORD_VALIDATION_REGEX = /\A(?=.*[A-Z])(?=.*\d)(?=.{4,})/x

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, format: PASSWORD_VALIDATION_REGEX
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.group_by { |e| e.beer.style }.map { |k, v| [v.map(&:score).reduce(:+) / v.count.to_f, k.itself] }.max[1]
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.group_by { |e| e.beer.brewery }.map { |k, v| [v.map(&:score).reduce(:+) / v.count.to_f, k.itself] }.max[1]
  end
end
