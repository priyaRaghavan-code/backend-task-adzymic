require "test/unit"
require_relative './card'
include Test::Unit::Assertions

class CardTest < Test::Unit::TestCase

  object = Cards.new
  @@get_by_set_result = object.get_by_set
  @@get_by_rarity_result = object.get_by_rarity
  @@colors =  ["red","blue"]
  @@get_by_colors_result = object.get_by_colors("KTK", @@colors)

  def test_type_assertion_of_get_by_set
    assert_kind_of(Array, @@get_by_set_result, "The result should be an Array")
    assert(@@get_by_set_result.length == 0 || (@@get_by_set_result.length > 0 && @@get_by_set_result[0].class == Hash), "The result should be an Array of Hash")
  end
  
  def test_get_by_set_result_content
    assert(@@get_by_set_result.length == 0 || @@get_by_set_result[0].has_key?("set"), "The result should have Key named set")
    assert(@@get_by_set_result.length == 0 || @@get_by_set_result[0].has_key?("colors"), "The result should have Key named colors")
    assert(@@get_by_set_result.length == 0 || @@get_by_set_result[0].has_key?("rarity"), "The result should have Key named rarity")
    assert_kind_of(String, @@get_by_set_result.length != 0 ? @@get_by_set_result[0]["set"] : "", "")
  end

  def test_consecutive_sets
    is_valid = true
    if @@get_by_set_result.length != 0
      container = [@@get_by_set_result[0]["set"]]
    end
    len = @@get_by_set_result.length - 1
    len.times.each do |i|
      next_set = @@get_by_set_result[i+1]["set"]
      if @@get_by_set_result[i]["set"] != next_set
        if container.include?(next_set)
          is_valid = false
          break
        else
          container.push(next_set)
        end
      end
    end
    assert(is_valid, "The result elements should come in a consecutive order")
  end

  def test_type_assertion_of_get_by_rarity
    assert_kind_of(Array, @@get_by_rarity_result, "The result should be an Array")
    assert(@@get_by_rarity_result.length == 0 || (@@get_by_rarity_result.length > 0 && @@get_by_rarity_result[0].class == Hash), "The result should be an Array of Hash")
  end

  def test_get_by_rarity_result_content
    assert(@@get_by_rarity_result.length == 0 || @@get_by_rarity_result[0].has_key?("set"), "The result should have Key named set")
    assert(@@get_by_rarity_result.length == 0 || @@get_by_rarity_result[0].has_key?("colors"), "The result should have Key named colors")
    assert(@@get_by_rarity_result.length == 0 || @@get_by_rarity_result[0].has_key?("rarity"), "The result should have Key named rarity")
    assert_kind_of(String, @@get_by_rarity_result.length != 0 ? @@get_by_rarity_result[0]["rarity"] : "", "")
  end

  def test_type_assertion_of_get_by_colors
    assert_kind_of(Array, @@get_by_colors_result, "The result should be an Array")
    assert(@@get_by_colors_result.length == 0 || (@@get_by_colors_result.length > 0 && @@get_by_colors_result[0].class == Hash), "The result should be an Array of Hash")
  end

  def test_get_by_colors_result_content
    assert(@@get_by_colors_result.length == 0 || @@get_by_colors_result[0].has_key?("set"), "The result should have Key named set")
    assert(@@get_by_colors_result.length == 0 || @@get_by_colors_result[0].has_key?("colors"), "The result should have Key named colors")
    assert(@@get_by_colors_result.length == 0 || @@get_by_colors_result[0].has_key?("rarity"), "The result should have Key named rarity")
    assert_kind_of(String, @@get_by_colors_result.length != 0 ? @@get_by_colors_result[0]["colors"] : "", "")
  end

  def test_consecutive_sets_colors
    is_valid = true
    @@get_by_colors_result.each do |card|
      if card["set"] && (card["colors"].size == @@colors.size && card["colors"] & @@colors == @@colors)
        is_valid = false
        break
      end
    end
    assert(is_valid,  "The result elements should include only red and blue color and the set should be KTK")
  end

end