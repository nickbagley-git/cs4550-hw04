defmodule Practice.Factor do

  def factor(x) do
    # code to convert a string to an integer is from
    # stackoverflow.com/questions/22576658/convert-elixir-string-to-integer-or-float
    {intval, _} = :string.to_integer(to_char_list(x))
    factor_acc(intval, 2, [])
  end

  def factor_acc(x, factor, acc) do

    cond do
      rem(x, factor) === 0 ->
        y = div(x, factor)
        curr_acc = [factor | acc]
        factor_acc(y, factor, curr_acc)
      x > 1 ->
        factor_acc(x, factor + 1, acc)
      true ->
        Enum.reverse(acc)
    end
  end
end
