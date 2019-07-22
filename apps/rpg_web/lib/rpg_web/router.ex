defmodule RpgWeb.Router do
  use RpgWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RpgWeb do
    pipe_through :api
  end
end
