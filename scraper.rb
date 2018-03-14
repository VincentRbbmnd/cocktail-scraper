require 'rest-client'
require 'json'

ids = []
unique_count = 0
cocktails = []

while unique_count < 569 do
    r = RestClient.get('https://www.thecocktaildb.com/api/json/v1/1/random.php', { accept: :json })
    next unless r.code == 200

    json = JSON.parse(r.body)
    drink = json["drinks"][0]

    id = drink["idDrink"]
    puts id
    next if ids.include?(id.to_i)
    ids << id.to_i
    cocktails << drink
    unique_count += 1

    File.open("cocktails.json","a") do |f|
        f.puts(drink.to_json)
    end
end

