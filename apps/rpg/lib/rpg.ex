defmodule Rpg do
  @moduledoc """
  Rpg keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def get_or_create_room(room_id) do
    case Registry.lookup(Rpg.RoomRegistry, room_id) do
      [] ->
        DynamicSupervisor.start_child(Rpg.RoomSupervisor, {Rpg.Room, %{room_id: room_id}})

      [{room, _value}] ->
        IO.inspect(room)
        {:ok, room}
    end
  end
end
