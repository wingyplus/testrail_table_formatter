defmodule TestrailTableFormatter.CLI do
  @options [
    write: :boolean
  ]

  @aliases [
    w: :write
  ]

  def main(args) do
    {options, [path], _} = OptionParser.parse(args, aliases: @aliases, strict: @options)

    write? = Keyword.get(options, :write, false)

    content = File.read!(path)
    formatted = TestrailTableFormatter.format(content)

    if write? do
      File.write!(path, formatted)
    else
      IO.puts(formatted)
    end
  end
end
