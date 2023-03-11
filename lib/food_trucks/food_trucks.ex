defmodule FoodTrucks do
  @moduledoc """
  Interface for `FoodTrucks`.
  """

  @callback fetch_food_trucks(coordinates :: map()) :: list()

  @callback fetch_food_truck(truck_id :: String.t()) :: list()
end

defmodule FoodTrucksImpl do
  @moduledoc """
   `FoodTrucks` implementation.
  """

  defdelegate fetch_food_trucks(location), to: FoodTrucks.Services.FetchFoodtrucks, as: :call

  defdelegate fetch_food_truck(truck_id), to: FoodTrucks.Services.FetchFoodtruck, as: :call
end
