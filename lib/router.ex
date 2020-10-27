defmodule DistributedLogging.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/test" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode(body)
    IO.inspect(body)
    send_resp(conn, 200, "created")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
