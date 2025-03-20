defmodule JsonFormatter do
  def format(raw_json) do
    with {:ok, data} <- Jason.decode(raw_json) do
      atomized_data = deep_atomize(data)

      # Example conditional formatting: add style based on the "status" key
      style =
        case atomized_data[:status] do
          "ok" -> :green
          _ -> :default
        end

      Map.put(atomized_data, :style, style)
    else
      _error -> {:error, :invalid_json}
    end
  end

  defp deep_atomize(%{} = map) do
    map
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      Map.put(acc, String.to_atom(key), deep_atomize(value))
    end)
  end

  defp deep_atomize([head | tail]) do
    [deep_atomize(head) | deep_atomize(tail)]
  end

  defp deep_atomize([]), do: []
  defp deep_atomize(value), do: value
end

defmodule JsonFormatter.CLI do
  alias DataProcessor

  def main(args) do
    args
    |> Enum.map(&process_file/1)
    |> Enum.each(&IO.inspect/1)
  end

  defp process_file(path) do
    case DataProcessor.process_file(path) do
      {:error, reason} -> "Error: #{reason}"
      result -> result
    end
  end
end


defmodule DataProcessor do
  alias JsonFormatter

  def process_file(path) do
    case File.read(path) do
      {:ok, content} ->
        JsonFormatter.format(content)
      error ->
        error
    end
  end
end
