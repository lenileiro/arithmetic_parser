# ArithmeticParser

# ArithmeticParser

The `ArithmeticParser` module provides functionality to evaluate simple arithmetic expressions. It supports basic operations like addition, multiplication, and division, following the BODMAS rule for operation precedence.

## Examples

### Evaluating Basic Arithmetic Expressions

```elixir
# Addition
ArithmeticParser.evaluate("1 + 2")

# Multiplication
ArithmeticParser.evaluate("2 * 3")
# => 6

# Mixed Operations
ArithmeticParser.evaluate("1 + 2 * 3")
# => 7

# Division by Zero
ArithmeticParser.evaluate("1 / 0")
# =>
"""
error: Division by zero at line 1
             1 / 0
                 ^
"""

# Syntax Errors
ArithmeticParser.evaluate("3 + invalid")
# =>
 """
    error: Syntax error at line 1 :invalid
    3 + invalid
        ^
    """
```
