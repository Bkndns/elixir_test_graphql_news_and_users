# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :community,
  ecto_repos: [Community.Repo]

# Configures the endpoint
config :community, CommunityWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "u9jF6pyvW/JAHk4OJxcoS0liMf6lECZXYfhE0TnXhTGwl7e074tZzVEI5uqPX6B9",
  render_errors: [view: CommunityWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Community.PubSub,
  live_view: [signing_salt: "F2womMAS"]

config :community, Community.Guardian,
  issuer: "community",
  secret_key: "EzXTEQYJTtaHzQONUiTdG77qAfF+vYll"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
