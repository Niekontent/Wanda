import Config

config :wanda, socrata_base_url: System.get_env("SOCRATA_BASE_URL")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
