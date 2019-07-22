defmodule RpgWeb.RoomChannel do
  use RpgWeb, :channel

  def join("room:" <> room_id, payload, socket) do
    IO.inspect("joined")

    {:ok,
     socket
     |> assign(:room_id, room_id)}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("get_all_tokens", _payload, socket) do
    {:ok, room} = Rpg.get_or_create_room(socket.assigns.room_id)
    tokens = Rpg.Room.get_tokens(room)
    IO.inspect(tokens)
    {:reply, {:ok, %{tokens: tokens}}, socket}
  end

  def handle_in("token_moved", %{token_id: token_id, x: x, y: y}, socket) do
    {:ok, room} = Rpg.get_or_create_room(socket.assigns.room_id)
    newToken = Rpg.Room.move_token(%{id: token_id, x: x, y: y})
    broadcast!(socket, "token_moved", newToken)
    {:reply, {:ok, %{token: newToken}}, socket}
  end
end
