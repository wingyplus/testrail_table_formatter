defmodule TestrailTableFormatterTest do
  use ExUnit.Case
  doctest TestrailTableFormatter

  test "parse/1" do
    table = """
    || a | b | c
    || d1 | d2 | d3
    """

    assert TestrailTableFormatter.parse(table) == [
             ["a", "b", "c"],
             ["d1", "d2", "d3"]
           ]
  end

  test "format/1" do
    actual = """
    || a | b | c
    || d1 | d2 | d3
    """

    expected = """
    || a  | b  | c
    || d1 | d2 | d3
    """

    assert TestrailTableFormatter.format(actual) == expected
  end

  test "format/3 fill column" do
    actual = """
    || a | b |c
    || d
    """

    expected = """
    || a | b | c
    || d |   |
    """

    assert TestrailTableFormatter.format(actual) == expected
  end

  test "format/3 long text" do
    actual = """
    || a | b |c
    || dddddddddddddddddddddddddddddddddd | eeeeeeeeeeeeeeeeeeeeeeee|ffffffffffffffffffffffffffff
    """

    expected = """
    || a                                  | b                        | c
    || dddddddddddddddddddddddddddddddddd | eeeeeeeeeeeeeeeeeeeeeeee | ffffffffffffffffffffffffffff
    """

    assert TestrailTableFormatter.format(actual) == expected
  end
end
