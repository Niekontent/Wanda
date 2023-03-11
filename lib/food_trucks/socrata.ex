defmodule Socrata do
  @moduledoc """
  Socrata API integration interface
  """

  @callback fetch_food_trucks(location :: map()) :: {:ok, any()} | :error

  @callback fetch_food_truck(truck_id :: String.t()) :: {:ok, any()} | :error

  def current do
    Application.get_env(
      :wanda,
      :socrata_impl,
      SocrataImpl
    )
  end
end

defmodule SocrataImpl do
  @moduledoc """
  Socrata integration implementation
  """

  @behaviour Socrata

  use Tesla

  @required_location_keys ~w(latitude longitude radius)a

  def fetch_food_trucks(location) do
    location_query = build_query(location)

    client()
    |> Tesla.get("/resource/rqzj-sfat.json" <> location_query)
    |> parse_response()
  end

  def fetch_food_truck(truck_id) do
    client()
    |> Tesla.get("/resource/rqzj-sfat.json?objectid=#{truck_id}")
    |> parse_response()
  end

  defp build_query(location) do
    if has_required_keys_and_types?(location) do
      "?%24where=within_circle%28location%2C%20#{location.latitude}%2C%20#{location.longitude}%2C%20#{location.radius}%29"
    else
      ""
    end
  end

  defp parse_response({:ok, %Tesla.Env{body: body, status: 200}}), do: {:ok, body}

  defp parse_response(_), do: :error

  defp has_required_keys_and_types?(map) do
    Enum.all?(@required_location_keys, fn key ->
      Map.has_key?(map, key) && is_binary(Map.get(map, key))
    end)
  end

  defp client do
    middleware = [
      {Tesla.Middleware.BaseUrl, Application.get_env(:wanda, :socrata_base_url)},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end
end
