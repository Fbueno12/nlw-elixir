defmodule Wabanex.IMC do
  # exec terminal
  # iex -S mix <- inicia o "server"
  # chamando esse metodo
  # Wabanex.IMC.calculate("students.csv")
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    data = content
    |> String.split("\n")
    |> Enum.map(fn line -> parse_line(line) end)
    |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Error while opening the file. "}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
    |> IO.inspect()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
