class User < ApplicationRecord
  include RatingAverage
  has_secure_password
  PASSWORD_VALIDATION_REGEX = /\A(?=.*[A-Z])(?=.*\d)(?=.{4,})/x

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, format: PASSWORD_VALIDATION_REGEX
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
end
