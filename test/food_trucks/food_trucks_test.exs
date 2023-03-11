defmodule FoodTrucksTest do
  use ExUnit.Case

  describe "fetch_food_trucks/2" do
    test "returns list on success" do
      food_trucks_list = FoodTrucksImpl.fetch_food_trucks(%{}, 1000)
      assert 2 = length(food_trucks_list)
    end
    
    test "returns an empty list on failure" do
      assert [] = FoodTrucksImpl.fetch_food_trucks(%{}, 1000)
    end
  end
end
