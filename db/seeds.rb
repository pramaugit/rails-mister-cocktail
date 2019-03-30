# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

Dose.delete_all if Rails.env.development?
Ingredient.delete_all if Rails.env.development?
Cocktail.delete_all if Rails.env.development?

# url = "https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json"

cocktails_array = JSON.parse(open(url).read)

photos = [
  "https://images.pexels.com/photos/312080/pexels-photo-312080.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  "https://images.pexels.com/photos/1232152/pexels-photo-1232152.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  "https://images.pexels.com/photos/1265910/pexels-photo-1265910.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
]

counter = 0

cocktails_array.first(3).each do |cocktail|
  url = photos[counter]
  c = Cocktail.new(name: cocktail["name"])
  c.remote_photo_url = url
  p "Added #{c.name} to the list"
  c.save
  cocktail["ingredients"].each do |ing|
    unless ing["ingredient"].nil?
      i = Ingredient.find_or_create_by!(name: ing["ingredient"])
      p "Added #{i.name} to the list"
      Dose.create(description: ing["amount"].to_s + " " + ing["unit"], ingredient: i, cocktail: c )
    end
  end
  counter += 1
end
