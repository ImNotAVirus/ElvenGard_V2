defmodule ElvenGard.Protocol.Binary.ByteType do
  @moduledoc """
  Define a custom byte type (uint8_t) for game protocols
  """

  use ElvenGard.Type

  @impl ElvenGard.Type
  @spec encode(integer, list) :: bitstring
  def encode(byte, _opts) do
    <<byte::size(8)>>
  end

  @impl ElvenGard.Type
  @spec decode(bitstring, list) :: {integer, bitstring}
  def decode(bin, _opts) do
    <<
      byte::size(8),
      rest::binary
    >> = bin

    {byte, rest}
  end
end
