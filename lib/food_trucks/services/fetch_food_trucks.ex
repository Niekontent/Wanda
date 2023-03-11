defmodule FoodTrucks.Services.FetchFoodtrucks do
  @moduledoc """
  Service for fetching food trucks
  """

  alias FoodTrucks.FoodTruck

  def call(location) do
    location
    |> socrata_api().fetch_food_trucks()
    |> normalise()
  end

  defp normalise({:ok, food_trucks}) do
    Enum.map(food_trucks, fn truck -> FoodTruck.from(truck) end)
  end

  defp normalise(_), do: []

  defp socrata_api, do: Socrata.current() |> IO.inspect()
end
