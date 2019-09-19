defmodule Practice.Calc do
  def parse_float(text) do
    {num, err} = Float.parse(text)
    num
  end
	
  def nextOperatorInPrecedence(op) do
	cond do
		op == "*" -> "/"
		op == "/" -> "+"
		op == "+" -> "-"
		op == "-" -> :ok
	end
  end

  def multiply(left, right), do: left * right
  def add(left, right), do: left + right
  def subtract(left, right), do: left - right
  def divide(left, right), do: left / right

  def solve(left, right, op) do
	cond do
		op == "*" -> multiply(left, right)
		op == "/" -> divide(left, right)
		op == "+" -> add(left, right)
		op == "-" -> subtract(left, right)
	end
  end

  def evaluvate(list, op) when length(list) == 1 do 
	[hd | tl] = list
	hd
  end

  """
	Attribution: Referred the docs: https://hexdocs.pm/elixir/List.html for possible operations on a list and also referred link: https://stackoverflow.com/questions/18551814/find-indexes-from-list-in-elixir for the functionality of finding the index of an element in list

conversion of float to a string was referred from: https://stackoverflow.com/questions/38734113/elixir-convert-float-to-string
  """
  def evaluvate(list, op) when length(list) > 1 do
	case op != :ok do
		true -> (index = Enum.find_index(list, fn x -> x == op end)
		case index == :nil do
			true -> evaluvate(list, nextOperatorInPrecedence(op))
			false -> (
					opIndex = Enum.find_index(list, fn x -> x == op end)
					left = Enum.at(list, opIndex - 1)
					right = Enum.at(list, opIndex + 1)
					result = solve(parse_float(left), parse_float(right), op)
					newList = List.replace_at(list, opIndex, Float.to_string(result))
					|> List.delete_at(opIndex + 1)
					|> List.delete_at(opIndex - 1)
					mulIndex = Enum.find_index(newList, fn x -> x == "*" end)
					divIndex = Enum.find_index(newList, fn x -> x == "/" end)
					op = cond do
						mulIndex == :nil and divIndex == :nil -> nextOperatorInPrecedence(op)
						mulIndex != :nil and divIndex != :nil and mulIndex < divIndex -> "*"
						mulIndex != :nil and divIndex != :nil and mulIndex > divIndex -> "/"
						mulIndex == :nil and divIndex != :nil -> "/"
						mulIndex != :nil and divIndex == :nil -> "*"
					end
					evaluvate(newList, op)
				 )
		end)
		false -> evaluvate(list, op)
	end
  end

  def calc(expr) do
	listArr = String.split(expr, " ")
	mulIndex = Enum.find_index(listArr, fn x -> x == "*" end)
	divIndex = Enum.find_index(listArr, fn x -> x == "/" end)
	op = cond do
		mulIndex == :nil and divIndex == :nil -> "+"
		mulIndex != :nil and divIndex != :nil and mulIndex < divIndex -> "*"
		mulIndex != :nil and divIndex != :nil and mulIndex > divIndex -> "/"
		mulIndex == :nil and divIndex != :nil -> "/"
		divIndex == :nil and mulIndex != :nil -> "*"
	end
	result = evaluvate(listArr, op)	
	{num, _} = Float.parse(result)
	num
  end
end

