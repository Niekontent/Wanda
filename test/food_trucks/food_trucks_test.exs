defmodule FoodTrucksTest do
  use ExUnit.Case, async: true

  import Mox

  alias FoodTrucks.FoodTruck

  describe "fetch_food_trucks/1" do
    setup do
      %{location_params: %{latitude: "37.76", longitude: "-122.39", radius: "500"}}
    end

    test "returns list on success", %{location_params: location_params} do
      mocked_body = [
        %{
          "address" => "185 BERRY ST",
          "facilitytype" => "Truck",
          "fooditems" => "everything except for hot dogs",
          "locationdescription" => "BERRY ST: 03RD ST to 04TH ST (100 - 199)",
          "objectid" => "1652610"
        },
        %{
          "address" => "MARY ST: MINNAT",
          "facilitytype" => "Truck",
          "fooditems" => "Multiple Food Trucks & Food Types",
          "locationdescription" => "MARY ST: MINNA ST to NATOMA ST (24 - 69)",
          "objectid" => "7852457"
        }
      ]

      SocrataMock
      |> expect(:fetch_food_trucks, fn _ ->
        {:ok, mocked_body}
      end)

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

    test "list is mapped to FoodTruck", %{location_params: location_params} do
      mocked_body = [
        %{
          "address" => "185 BERRY ST",
          "facilitytype" => "Truck",
          "fooditems" => "everything except for hot dogs",
          "locationdescription" => "BERRY ST: 03RD ST to 04TH ST (100 - 199)",
          "objectid" => "1652610"
        },
        %{
          "address" => "MARY ST: MINNAT",
          "facilitytype" => "Truck",
          "fooditems" => "Multiple Food Trucks & Food Types",
          "locationdescription" => "MARY ST: MINNA ST to NATOMA ST (24 - 69)",
          "objectid" => "7852457"
        }
      ]

      SocrataMock
      |> expect(:fetch_food_trucks, fn _ ->
        {:ok, mocked_body}
      end)

      food_trucks_list = FoodTrucksImpl.fetch_food_trucks(location_params)

      Enum.each(food_trucks_list, fn truck -> assert %FoodTruck{} = truck end)
    end
  end

  describe "fetch_food_truck/1" do
    test "returns item on success" do
      mocked_body = [
        %{
          "address" => "185 BERRY ST",
          "facilitytype" => "Truck",
          "fooditems" => "everything except for hot dogs",
          "locationdescription" => "BERRY ST: 03RD ST to 04TH ST (100 - 199)",
          "objectid" => "1652610"
        }
      ]

      SocrataMock
      |> expect(:fetch_food_truck, fn "1652610" ->
        {:ok, mocked_body}
      end)

      refute nil == FoodTrucksImpl.fetch_food_truck("1652610")
    end

    test "returns nil on failure" do
      SocrataMock
      |> expect(:fetch_food_truck, fn "1652610" ->
        :error
      end)

      assert nil == FoodTrucksImpl.fetch_food_truck("1652610")
    end

    test "item is mapped to FoodTruck" do
      mocked_body = [
        %{
          "address" => "185 BERRY ST",
          "facilitytype" => "Truck",
          "fooditems" => "everything except for hot dogs",
          "locationdescription" => "BERRY ST: 03RD ST to 04TH ST (100 - 199)",
          "objectid" => "1652610"
        }
      ]

      SocrataMock
      |> expect(:fetch_food_truck, fn "1652610" ->
        {:ok, mocked_body}
      end)

      assert %FoodTruck{} = FoodTrucksImpl.fetch_food_truck("1652610")
    end
  end
end
