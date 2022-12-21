json.extract! brewery, :name, :year, :active
json.beercount brewery.beers.count
json.url brewery_url(brewery, format: :json)
