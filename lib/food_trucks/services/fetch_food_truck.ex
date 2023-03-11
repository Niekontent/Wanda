defmodule FoodTrucks.Services.FetchFoodtruck do
  @moduledoc """
  Service for fetching food truck
  """

  alias FoodTrucks.FoodTruck

  def call(truck_id) do
    truck_id
    |> socrata_api().fetch_food_truck()
    |> normalise()
  end

  defp normalise({:ok, food_truck}) do
    food_truck
    |> hd()
    |> FoodTruck.from()
  end

  defp normalise(_), do: nil

  defp socrata_api, do: Socrata.current()
end
