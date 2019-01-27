defmodule LoginServer.Frontend do
  @moduledoc """
  Documentation for LoginServer.Frontend.
  """

  use ElvenGard.Game.Frontend,
    packet_resolver: LoginServer.PacketResolver,
    port: 4002

  require Logger
  alias ElvenGard.Game.Client

  @impl true
  def handle_init(args) do
    port = get_in(args, [:port])
    Logger.info("Login server started on port #{port}")
  end

  @impl true
  def handle_connection(socket, transport) do
    client = Client.new(socket, transport)
    Logger.info("New connection: #{client.id}")
    Logger.info("#{inspect client.metadata}")
    client
  end

  @impl true
  def handle_disconnection(%Client{id: id} = _client, reason) do
    Logger.info("#{id} is now disconnected (reason: #{inspect(reason)})")
  end

  @impl true
  def handle_message(%Client{id: id} = _client, message) do
    Logger.info("New message from #{id} (len: #{byte_size(message)})")
  end

  # TODO: Change this function and remove `LoginServer.Crypto.encrypt` call.
  # Use the resolver instead
  @impl true
  def handle_halt_ok(%Client{id: id} = client, args) do
    e_packet = LoginServer.Crypto.encrypt(args)
    Logger.info("Client accepted: #{id}")
    Client.send(client, e_packet)
  end

  # TODO: Change this function and remove `LoginServer.Crypto.encrypt` call.
  # Use the resolver instead
  @impl true
  def handle_halt_error(%Client{id: id} = client, reason) do
    e_reason = LoginServer.Crypto.encrypt("fail #{inspect reason}")
    Logger.info("Client refused: #{id} - #{inspect reason}")
    Client.send(client, e_reason)
  end
end
