defmodule DistributedLogging.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  def hello_tharr(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello World")
  end

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
