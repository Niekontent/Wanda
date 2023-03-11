defmodule FoodTrucks.FoodTruck do
  @moduledoc """
  Fetched FoodTruck
  """

  defstruct ~w(address facility_type food_type location_description truck_id)a

  def from(data) do
    %__MODULE__{
      address: data["address"],
      facility_type: data["facilitytype"],
      food_type: data["fooditems"],
      location_description: data["locationdescription"],
      truck_id: data["objectid"]
    }
  end
end
