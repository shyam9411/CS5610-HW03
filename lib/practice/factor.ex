"""
Attribution: Looked at https://elixirschool.com/en/lessons/basics/modules/ for info on how to use conditions and defining methods. Also used files from: https://github.com/NatTuck/elixir-practice as template file for building on features.

Enum functionalities were explored in: https://hexdocs.pm/elixir/Enum.html
"""
defmodule Practice.Factor do
	def primeFactor(1, _, acc), do: acc
	def primeFactor(x, q, acc) when x > q and rem(x, q) != 0, do: primeFactor(x, q + 1, acc)
	def primeFactor(x, q, acc) when rem(x, q) == 0, do: primeFactor(div(x, q), q, [q | acc])
	
	def factor(x) do
		{num, _} = Integer.parse(x)
		primeFactor(num, 2, [])
		|> Enum.reverse()
	end
end
