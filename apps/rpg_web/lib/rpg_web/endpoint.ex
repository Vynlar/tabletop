defmodule RpgWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :rpg_web

  socket "/socket", RpgWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Static.IndexHtml,
    at: "/"

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: {:rpg_web, "priv/rpg-react/build/"},
    gzip: false,
    only: ~w(index.html static favicon.ico)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_rpg_web_key",
    signing_salt: "7zDWCevm"

  plug RpgWeb.Router
end
