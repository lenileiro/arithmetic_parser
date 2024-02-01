defmodule ArithmeticParser do
  def evaluate(str) do
    with {:ok, tokens, _} <- :lexer.string(to_charlist(str)) do
      case :parser.parse(tokens) do
        {:ok, tree} ->
          evaluate_tree(str, tree)

        {:error, {line, :parser, ['syntax error before: ', details]}} ->
          {:error, format_syntax_error(str, line, details)}
      end
    end
  end

  defp evaluate_tree(_str, {:num, value}), do: value

  defp evaluate_tree(str, {:op_add, left, right, _line}) do
    evaluate_tree(str, left) + evaluate_tree(str, right)
  end

  defp evaluate_tree(str, {:op_sub, left, right, _line}) do
    evaluate_tree(str, left) - evaluate_tree(str, right)
  end

  defp evaluate_tree(str, {:op_mul, left, right, _line}) do
    evaluate_tree(str, left) * evaluate_tree(str, right)
  end

  defp evaluate_tree(str, {:op_div, _, {:num, 0}, line}) do
    {:error, error(str, "0", "error: Division by zero at line #{line}")}
  end

  defp evaluate_tree(str, {:op_div, left, right, _line}) do
    evaluate_tree(str, left) / evaluate_tree(str, right)
  end

  defp format_syntax_error(str, line, [[_, ['unexpected_chars', _, chars], _]]) do
    error(str, chars, "error: Syntax error at line #{line} :#{chars}")
  end

  defp error(str, chars, message) do
    error_pos = calculate_error_position(chars, str)

    error_indicator = String.duplicate(" ", error_pos) <> "^"

    """
    #{message}
    #{str}
    #{error_indicator}
    """
  end

  def calculate_error_position(chars, str) do
    [{start_position, _}] = Regex.run(~r/#{chars}/, str, return: :index)
    start_position
  end
end
