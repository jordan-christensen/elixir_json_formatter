defmodule JsonFormatterTest do
  use ExUnit.Case
  alias JsonFormatter

  describe "format/1" do
    test "formats valid JSON correctly" do
      # Set up raw JSON
      raw_json = ~s({"status": "ok", "data": {"value": 42}})

      # The expected output might be a formatted map or a string with conditional styling.
      # For example, suppose we want to highlight "ok" status in green.
      expected_output = %{status: "ok", data: %{value: 42}, style: :green}

      # Act & Assert: The function should transform raw_json into the expected output.
      assert JsonFormatter.format(raw_json) == expected_output
    end

    test "handles invalid JSON gracefully" do
      raw_json = "invalid json"
      # You might decide to return an error tuple or raise an exception.
      assert {:error, _reason} = JsonFormatter.format(raw_json)
    end
  end
end
