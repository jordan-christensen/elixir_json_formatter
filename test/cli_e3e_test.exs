defmodule CLIEndToEndTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias JsonFormatter.CLI

  setup do
    # Create a temporary file with JSON content
    file_path = "tmp_cli_test.json"
    json_content = ~s({"status": "ok", "data": {"value": 42}})
    File.write!(file_path, json_content)

    # Clean up after the test
    on_exit(fn -> File.rm(file_path) end)
    {:ok, file_path: file_path}
  end

  test "CLI main processes file and outputs formatted JSON", %{file_path: file_path} do
    output = capture_io(fn ->
      CLI.main([file_path])
    end)

    # Depending on your version of IO.inspect, the output might be formatted with a newline.
    # Adjust expected_output accordingly.
    expected_output = "%{data: %{value: 42}, status: \"ok\", style: :green}\n"
    assert output == expected_output
  end
end
