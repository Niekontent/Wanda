defmodule FoodTrucksTest do
  use ExUnit.Case, async: true

  import Mox

  describe "fetch_food_trucks/1" do
    test "returns list on success" do
      SocrataMock
      |> expect(:fetch_food_trucks, fn _ ->
        {:ok, []}
      end)

      location_params = %{latitude: "37.76", longitude: "-122.39", radius: "500"}

      food_trucks_list = FoodTrucksImpl.fetch_food_trucks(location_params)
      assert 2 = length(food_trucks_list)
    end

    test "returns an empty list on failure" do
      SocrataMock
      |> expect(:fetch_food_trucks, fn _ ->
        :error
      end)

      assert [] = FoodTrucksImpl.fetch_food_trucks(%{})
    end
  end
end
