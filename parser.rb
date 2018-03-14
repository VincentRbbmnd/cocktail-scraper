require 'json'

# { 'drinkName': { 'title': 'drinkName', 'ingredients': ['ingredient1', 'ingredient2'], 'instructions': 'Do this. Then that.' }, '...': {...} }
parsed_cocktails = Hash.new

def collect_ingredients(json)
    i = 1
    collected_ingredients = []

    current = json['strIngredient' + i.to_s]
    while !current.nil? && !current.empty? && i <= 15 do
        collected_ingredients << current

        i += 1
        current = json['strIngredient' + i.to_s]
    end

    collected_ingredients
end

File.open('cocktails.json', 'r').each_line do |line|
    json = JSON.parse(line)
    title = json['strDrink']
    ingredients = collect_ingredients(json)
    instructions = json['strInstructions']

    parsed_cocktails[title] = { title: title, ingredients: ingredients, instructions: instructions }
end

File.open('cocktails-title-ingredients-instructions.json', 'w') do |f|
    f.write(parsed_cocktails.to_json)
end

