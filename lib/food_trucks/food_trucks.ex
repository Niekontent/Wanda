defmodule FoodTrucks do
  @moduledoc """
  Interface for `FoodTrucks`.
  """

  @callback fetch_food_trucks(coordinates :: map(), radius :: binary()) :: []

  @callback fetch_food_truck(truck_id :: String.t()) :: []
end


defmodule FoodTrucksImpl do
  @moduledoc """
   `FoodTrucks` implementation.
  """

  defdelegate fetch_food_trucks(coordinates, radius), to: Socrata, as: :fetch_food_trucks

  defdelegate fetch_food_truck(truck_id), to: Socrata, as: :fetch_food_truck
end
