require 'net/http'
require 'json'

class Cards
  @@cards = nil
  def initialize()
    response = Net::HTTP.get(URI.parse('https://api.magicthegathering.io/v1/cards'))
    @@cards = JSON.parse(response)
  end
  
  def get_by_set
    grouped_result = {}
    @@cards["cards"].each do |card|
      if grouped_result.has_key?(card["set"])
        grouped_result[card["set"]].push(card)
      else
        grouped_result[card["set"]] = [card]
      end
    end
    grouped_result.values.flatten
  end
  
  def get_by_rarity
    grouped_result = {}
    @@cards["cards"].each do |card|
      if grouped_result.has_key?(card["set"])
        temp = grouped_result[card["set"]]
        if temp.has_key?(card["rarity"])
          grouped_result[card["set"]][card["rarity"]].push(card)
        else
          grouped_result[card["set"]][card["rarity"]] = [card]
        end
      else
        grouped_result[card["set"]] = {card["rarity"] => [card]}
      end
    end
    result = []
    grouped_result.each do |set, card|
      result.concat(card.values.flatten)
    end
    result
  end
  
  def get_by_colors(set_name, colors)
    filtered = []
    @@cards["cards"].each do |card|
      is_valid = card["set"] == set_name && 
                card["colors"].size == colors.size &&
                card["colors"] & colors == colors
      if is_valid
        filtered.push(card)
      end
    end
    filtered
  end
end

def get_final_grouped_result(option)
  object = Cards.new
  case option[0]
  when "set"
    cards = object.get_by_set
    puts cards
  when "rarity"
    cards = object.get_by_rarity
    puts cards
  when "colors"
    if option.length == 1
      card_type = "KTK"
      colors = ["red", "blue"]
    else
      card_type = option[1]
      colors = option[2].split(",")
    end
    cards = object.get_by_colors(card_type, colors)
    puts cards
  end
end


get_final_grouped_result(ARGV)