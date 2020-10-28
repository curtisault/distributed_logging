defmodule DistributedLoggingTest do
  use ExUnit.Case
  use Plug.Test
  doctest DistributedLogging


  # Hello World Test
  test "greets the world" do
    assert DistributedLogging.hello() == :world
  end

  # Test Router
  @opts DistributedLogging.Router.init([])

  test "router hello" do
    conn = conn(:get, "/hello")
    conn = DistributedLogging.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end

  test "router test" do
    conn = conn(:post, "/test", "my test")
    conn = DistributedLogging.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "created"
  end

  test "router 404" do
    conn = conn(:get, "/bombed")
    conn = DistributedLogging.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Not Found"
  end

  # Node 1
  @opts DistributedLogging.Node1.init([])

  test "node 1 status" do
    conn = conn(:get, "/status")
    conn = DistributedLogging.Node1.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Working from Port 80."
  end

  test "node 1 event 1" do
    conn = conn(:post, "/event", "event 1")
    conn = DistributedLogging.Node1.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 201
  end

  test "node 1 log" do
    conn = conn(:get, "/log")
    conn = DistributedLogging.Node1.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body != nil
  end

  # Node 2
  @opts DistributedLogging.Node2.init([])

  test "node 2 status" do
    conn = conn(:get, "/status")
    conn = DistributedLogging.Node2.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Working from Port 80."
  end

  test "node 2 event 1" do
    conn = conn(:post, "/event", "event 1")
    conn = DistributedLogging.Node2.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 201
  end

  test "node 2 log" do
    conn = conn(:get, "/log")
    conn = DistributedLogging.Node2.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body != nil
  end

  # Node 3
  @opts DistributedLogging.Node3.init([])

  test "node 3 status" do
    conn = conn(:get, "/status")
    conn = DistributedLogging.Node3.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Working from Port 80."
  end

  test "node 3 event 1" do
    conn = conn(:post, "/event", "event 1")
    conn = DistributedLogging.Node3.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 201
  end

  test "node 3 log" do
    conn = conn(:get, "/log")
    conn = DistributedLogging.Node3.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body != nil
  end

  # Log Tests
  test "log write to log node 1" do
    body = "test event 1"
    assert DistributedLogging.Log.write_to_log(:node1, body) == :ok
  end

  test "log read log" do
    {isOk, contents} = DistributedLogging.Log.read_log(:node1)
    assert isOk == :ok
    assert contents != nil
  end
end
