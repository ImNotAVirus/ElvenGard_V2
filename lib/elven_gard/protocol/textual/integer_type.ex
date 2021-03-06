defmodule ElvenGard.Protocol.Textual.IntegerType do
  @moduledoc """
  Define a custom integer type for game protocols
  """

  use ElvenGard.Type

  @impl ElvenGard.Type
  @spec encode(integer, list) :: String.t()
  def encode(number, _opts) do
    Integer.to_string(number)
  end

  @impl ElvenGard.Type
  @spec decode(String.t(), list) :: integer
  def decode(str, _opts) do
    String.to_integer(str)
  end
end
