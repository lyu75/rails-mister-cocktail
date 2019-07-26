# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

# destroy all
Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

urlR = 'https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json'
urlI = 'https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/ingredients.json'

is = JSON.parse(open(urlI).read)
is.each_pair do |k, v|
  Ingredient.create(name: k)
end

p Ingredient.all.each do |i|
  p i
end

rs = JSON.parse(open(urlR).read)
rs.each do |r|
  cocktail = Cocktail.create(name: r['name'])
  r['ingredients'].each do |i|
    ing = Ingredient.where(["name = ?", i['ingredient']]).first
    d = "#{i['amount']} #{i['unit']}"
    Dose.create(description: d, ingredient: ing, cocktail: cocktail)
  end
end

Cocktail.all.each do |c|
  p c.ingredients
end
