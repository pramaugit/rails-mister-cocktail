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

url = "https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json"


cocktails_array = JSON.parse(open(url).read)


cocktails_array.each do |cocktail|
  p cocktail
  c = Cocktail.create!(name: cocktail["name"])
  p "Added #{c.name} to the list"
  cocktail["ingredients"].each do |ing|
    unless ing["ingredient"].nil?
      i = Ingredient.find_or_create_by!(name: ing["ingredient"])
      p "Added #{i.name} to the list"
      Dose.create(description: ing["amount"].to_s + " " + ing["unit"], ingredient: i, cocktail: c )
    end
  end
end
