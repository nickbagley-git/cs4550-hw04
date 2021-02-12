defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # this function only handles inputs that are numbers and operators in an
    # infix notation that is seperated by a single space
    exprlist = String.split(expr, " ")
    postfix = convertpostfix(exprlist, [], [])
    {num, ""} = Float.parse(eval(postfix, []))
    num
  end

  # This function will only work with an expression list that consists of
  # numbers and operators in an infix notation
  def convertpostfix(exprlist, output, operators) do
    if length(exprlist) === 0 do
      if length(operators) === 0 do
        output
      else
        output++operators
      end
    else
      opvalues = %{"+" => 1, "-" => 1, "*" => 2, "/" => 2}
      [head | tail] = exprlist

      if Map.has_key?(opvalues, head) do
        cond do
          length(operators) === 0 ->
            convertpostfix(tail, output, [head]++operators)
          opvalues[head] > opvalues[Enum.at(operators, 0)] ->
            convertpostfix(tail, output, [head]++operators)
          opvalues[head] === opvalues[Enum.at(operators, 0)] ->
            [ophead | optail] = operators
            convertpostfix(tail, output++[ophead], [head]++optail)
          opvalues[head] < opvalues[Enum.at(operators, 0)] ->
            [ophead | optail] = operators
            convertpostfix(exprlist, output++[ophead], optail)
        end
      else
        convertpostfix(tail, output++[head], operators)
      end
    end
  end

  def eval(expr, stack) do
    opvalues = ["+", "-", "*", "/"]
    if length(expr) === 0 do
      Enum.at(stack, 0)
    else
      [head | tail] = expr

      if Enum.member?(opvalues, head) do
        {x, ""} = Float.parse(Enum.at(stack, 0))
        {y, ""} = Float.parse(Enum.at(stack, 1))
        z = cond do
          head === "+" ->
            x + y
          head === "-" ->
            y - x
          head === "*" ->
            x * y
          head === "/" ->
            y / x
      end
      newstack1 = List.delete_at(stack, 0)
      newstack2 = List.delete_at(newstack1, 0)
      newstack3 = List.insert_at(newstack2, 0, Float.to_string(z))
      eval(tail, newstack3)
      #placeholder
      else
        eval(tail, [head]++stack)
      end
    end
  end


end
