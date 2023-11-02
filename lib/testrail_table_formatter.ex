defmodule TestrailTableFormatter do
  @moduledoc """
  Documentation for `TestrailTableFormatter`.
  """

  @whitespace_prefix " "
  @whitespace_suffix " "

  def format(table) when is_binary(table) do
    table =
      table
      |> parse()
      |> fill_columns()

    max_width_columns = determine_max_width_columns(table)

    table
    |> Enum.map(fn row ->
      format_line(max_width_columns, row, [])
    end)
    |> IO.iodata_to_binary()
  end

  defp format_line([_max_width], [""], line) do
    # Intersperse will insert between element, not for the last element.
    ["||", line |> Enum.intersperse("|") |> Enum.reverse(), ?\|, ?\n]
  end

  defp format_line([_max_width], [column], line) do
    line = [
      [
        @whitespace_prefix,
        column
      ]
      | line
    ]

    ["||", line |> Enum.intersperse("|") |> Enum.reverse(), ?\n]
  end

  defp format_line([max_width | max_width_columns], [column | columns], line) do
    format_line(max_width_columns, columns, [
      [
        @whitespace_prefix,
        column,
        String.duplicate(" ", max_width - String.length(column)),
        @whitespace_suffix
      ]
      | line
    ])
  end

  defp determine_max_width_columns(table) do
    table
    |> Enum.zip()
    |> Enum.map(fn column ->
      column
      |> Tuple.to_list()
      |> Enum.map(fn elem -> elem |> String.trim() |> String.length() end)
      |> Enum.max()
    end)
  end

  defp fill_columns(table) do
    max_column =
      table
      |> Enum.map(&length/1)
      |> Enum.max()

    table
    |> Enum.map(fn row ->
      row ++ List.duplicate("", max_column - length(row))
    end)
  end

  def parse(table) when is_binary(table) do
    for line <- String.split(table, "\n", trim: true) do
      parse_line(line)
    end
  end

  def parse_line(<<"||">> <> rest) do
    rest
    |> String.trim()
    |> String.split("|")
    |> Enum.map(&String.trim/1)
  end

  def parse_line(line) do
    raise """
    ERROR: cannot parse line:
      
      #{line}
      ^
    """
  end
end
