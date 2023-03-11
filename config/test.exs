import Config

# Mocks
config :food_trucks, :socrata_impl, SocrataMock

config :tesla, adapter: Tesla.Mock
