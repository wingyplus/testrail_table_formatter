defmodule TestrailTableFormatter.CLI do
  @options [
    write: :boolean,
    read_from_stdin: :boolean
  ]

  @aliases [
    w: :write,
    i: :read_from_stdin
  ]

  def main(args) do
    {options, argv, _} = OptionParser.parse(args, aliases: @aliases, strict: @options)

    from_stdin? = Keyword.get(options, :read_from_stdin, false)
    write? = Keyword.get(options, :write, false)

    cond do
      write? and from_stdin? ->
        raise "ERROR: Cannot specify `--write` and `--read_from_stdin` at the same time."

      from_stdin? ->
        IO.read(:stdio, :all) |> format() |> IO.puts()

      true ->
        [path] = argv
        content = File.read!(path)
        formatted = format(content)

        if write? do
          File.write!(path, formatted)
        else
          IO.puts(formatted)
        end
    end
  end

  defdelegate format(content), to: TestrailTableFormatter
end
