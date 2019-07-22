defmodule Rpg.Room do
  use GenServer

  alias Rpg.Token

  # Client

  def start_link(%{room_id: room_id}) do
    # you may want to register your server with `name: __MODULE__`
    # as a third argument to `start_link`
    GenServer.start_link(__MODULE__, [], name: {:via, Registry, {Rpg.RoomRegistry, room_id}})
  end

  def insert(room_id, %Token{} = token) do
    GenServer.cast(room_id, {:insert_token, token})
  end

  def get_tokens(room_id) do
    GenServer.call(room_id, {:get_all_tokens})
  end

  def move_token(room_id, %{id: id, x: x, y: y} = payload) do
    GenServer.call(room_id, {:move_token, payload})
  end

  # Server

  def init(_args) do
    {:ok, %{tokens: []}}
  end

  def handle_call({:get_all_tokens}, _from, %{tokens: tokens}) do
    {:reply, tokens, %{tokens: tokens}}
  end

  def handle_call({:move_token, %{id: id, x: x, y: y}}, _from, %{tokens: tokens}) do
    newTokens =
      tokens
      |> Enum.map(fn token ->
        if token.id == id do
          Map.merge(token, %{x: x, y: y})
        else
          token
        end
      end)

    {:reply, Enum.find(newTokens, fn token -> token.id == id end), %{tokens: newTokens}}
  end

  def handle_cast({:insert_token, token}, %{tokens: tokens}) do
    {:noreply, %{tokens: [token | tokens]}}
  end
end
