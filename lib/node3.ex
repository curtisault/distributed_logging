defmodule DistributedLogging.Node3 do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)


  get "/status" do
    port = :cowboy_req.port(conn)
    send_resp(conn, 200, "Working from Port #{port}.")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

end
