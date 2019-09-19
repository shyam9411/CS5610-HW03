defmodule Practice.Palindrome do

  def palindrome(expr) do
	case expr == "" do
		true -> false
		false -> String.reverse(expr) == expr
	end
  end
end
