defmodule ArithmeticParserTest do
  use ExUnit.Case

  test "evaluate addition" do
    assert ArithmeticParser.evaluate("1 + 2") == 3
  end

  test "evaluate multiplication" do
    assert ArithmeticParser.evaluate("2 * 3") == 6
  end

  test "evaluate mixed operations" do
    assert ArithmeticParser.evaluate("1 + 2 * 3") == 7
  end

  test "evaluates expression following BODMAS" do
    assert ArithmeticParser.evaluate("3 + 4 * 2") == 11
    assert ArithmeticParser.evaluate("10 + 2 * 6") == 22
    assert ArithmeticParser.evaluate("100 / 2 * 6") == 300
    assert ArithmeticParser.evaluate("(3 + 4) * 2") == 14
  end

  test "handles division by zero" do
    assert ArithmeticParser.evaluate("1 / 0") ==
             """
             error: Division by zero at line 1
             1 / 0
                 ^
             """
  end

  test "visual error message indicates error start" do
    input = "3 + invalid"

    expected_message = """
    error: Syntax error at line 1 :invalid
    3 + invalid
        ^
    """

    assert ArithmeticParser.evaluate(input) == expected_message
  end
end
