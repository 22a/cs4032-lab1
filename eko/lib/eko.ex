defmodule Eko do
  def be_client(address_string, port_string, raw_message) do
    address = address_string
              |> String.split(".")
              |> Enum.map(fn (str) -> String.to_integer(str) end)
              |> List.to_tuple
    port = String.to_integer port_string
    message = URI.encode raw_message

    connect(address, port)
    |> send_get(message)
    |> listen_loop
  end

  def connect(address, port) do
    {:ok, socket} = :gen_tcp.connect(address, port, [:binary, active: false])
    socket
  end

  defp listen_loop(socket) do
    socket
    |> read_line
    |> IO.puts

    listen_loop(socket)
  end

  defp read_line(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        data
      {:error, :closed} ->
        System.halt(0)
    end
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end

  defp send_get(socket, message) do
    get_body = "GET /echo.php?message=#{message} HTTP/1.0\r\n\r\n"
    write_line(get_body, socket)
    socket
  end
end
