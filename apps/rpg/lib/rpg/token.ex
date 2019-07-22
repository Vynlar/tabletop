defmodule Rpg.Token do
  @derive {Jason.Encoder, only: [:x, :y, :id]}
  defstruct x: 0, y: 0, id: 0
end
