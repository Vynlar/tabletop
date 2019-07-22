defmodule Rpg.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Rpg.Repo,
      {Registry, keys: :unique, name: Rpg.RoomRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: Rpg.RoomSupervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Rpg.Supervisor)
  end
end
