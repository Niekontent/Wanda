import Config

# Mocks
config :wanda, :socrata_impl, SocrataMock

config :tesla, adapter: Tesla.Mock
