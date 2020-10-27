defmodule DistributedLogging.Node1 do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)


  get "/status" do
    send_resp(conn, 200, "Working from Port 5000.")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

end
