defmodule DataProcessorIntegrationTest do
  use ExUnit.Case
  alias DataProcessor

  setup do
    # Create a temporary file with JSON content
    file_path = "tmp_test.json"
    json_content = ~s({"status": "ok", "data": {"value": 42}})
    File.write!(file_path, json_content)

    # Ensure the file is rmeoved after the test
    on_exit(fn -> File.rm(file_path) end)

    {:ok, file_path: file_path}
  end

  test "process_file returns correctly formatted output", %{file_path: file_path} do
    expected_output = %{status: "ok", data: %{value: 42}, style: :green}
    assert DataProcessor.process_file(file_path) == expected_output
  end
end
