defmodule DistributedLogging.Log do
  def write_to_log(node, event) do
    {node, path} = get_node_path(node)
    file = "event.log"
    fullPath = path <> file

    case File.open(fullPath) do
      {:error, :enoent} -> create_and_write_to_log(path, file, event)
      {:ok, file} -> open_and_write_to_log(fullPath, event)
    end
  end

  def read_log(node) do
    {node, path} = get_node_path(node)
    file = "event.log"
    fullPath = path <> file

    case File.open(fullPath) do
      {:error, :enoent} -> create_and_read_log(path, file)
      {:ok, file} -> File.read(fullPath)
    end
  end

  defp get_node_path(node) do
    case node do
      :node1 -> {node, "./node/node_1/data/"}
      :node2 -> {node, "./node/node_2/data/"}
      :node3 -> {node, "./node/node_3/data/"}
      _ -> {:error, :enoent}
    end
  end

  defp create_and_read_log(path, file) do
    fullPath = create_event_log_path(path, file)
    File.open(fullPath, [:write])
    IO.puts("Reading from #{fullPath}")
    File.read(fullPath)
  end

  defp create_and_write_to_log(path, file, event) do
    fullPath = create_event_log_path(path, file)
    IO.puts("Attempting to read #{fullPath}")
    open_and_write_to_log(fullPath, event)
  end

  defp create_event_log_path(path, file) do
    File.mkdir_p(path)
    IO.puts("Created dir #{path}")
    path <> file
  end

  defp open_and_write_to_log(fullPath, event) do
    eventWithTimestamp = "#{DateTime.utc_now}" <> " " <> event
    content =
      case File.read(fullPath) do
        {:error, :enoent} -> eventWithTimestamp
        {:ok, fileContent} -> fileContent <> "\n" <> eventWithTimestamp
      end

    {:ok, file} = File.open(fullPath, [:write])

    IO.binwrite(file, content)

    case File.read(fullPath) do
      {:ok, body} -> IO.puts("Successfully read file.")
      {:error, reason} -> IO.inspect(reason)
    end
  end

end
