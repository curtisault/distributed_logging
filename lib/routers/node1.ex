defmodule DistributedLogging.Node1 do
  use Plug.Router
  use Plug.Debugger
  require Logger
  require DistributedLogging.Log

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/status" do
    port = :cowboy_req.port(conn)
    send_resp(conn, 200, "Working from Port #{port}.")
  end

  get "/log" do
    {:ok, content} = DistributedLogging.Log.read_log(:node1)
    IO.puts(content)
    send_resp(conn, 200, content)
  end

  post "/event" do
    {:ok, body, conn} = read_body(conn)
    IO.inspect(body)
    IO.inspect(conn)
    fileData = DistributedLogging.Log.write_to_log(:node1, body)
    send_resp(conn, 201, "Record Added:\n #{body}")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

end
