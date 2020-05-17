# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tnd,
  ecto_repos: [Tnd.Repo]

# Configures the endpoint
config :tnd, TndWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wf40ir0UpY5SEn4WXvafBy0Ea7TcMfr02nr/Y+uRwrfz1GFJPptBl0vYDUCCiGOS",
  render_errors: [view: TndWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tnd.PubSub,
  live_view: [signing_salt: "lUNmvn4f"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
