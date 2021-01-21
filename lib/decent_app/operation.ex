defmodule DecentApp.Operation do
  alias DecentApp.Balance

  def apply_command("COINS", list, balance) do
    balance = Balance.apply_balance(balance, 5)
    {list, balance}
  end

  def apply_command("NOTHING", list, balance) do
    balance = Balance.apply_balance(balance)
    {list, balance}
  end

  def apply_command("DUP", list, balance) do
    balance = Balance.apply_balance(balance)
    list = list ++ [List.last(list)]
    {list, balance}
  end

  def apply_command("POP", list, balance) do
    balance = Balance.apply_balance(balance)
    {_, list} = List.pop_at(list, length(list) - 1)
    {list, balance}
  end

  def apply_command("+", list, balance)  do
    balance = Balance.apply_balance(balance, -2)
    [first, second | list] = Enum.reverse(list)
    
    list = Enum.reverse(list) ++ [first + second]
    {list, balance}
  end

  def apply_command("-", list, balance)do
    balance = Balance.apply_balance(balance)
    [first, second | list] = Enum.reverse(list)
    list = Enum.reverse(list) ++ [first - second]
    {list, balance}
  end

  def apply_command("*", list, balance) do
    IO.inspect balance
    IO.inspect balance = Balance.apply_balance(balance, -3)
    [first, second, third | list] = Enum.reverse(list)
    list = Enum.reverse(list) ++ [first * second * third]
    {list, balance}
  end

  def apply_command(command, list, balance) when is_integer(command) do
    balance = Balance.apply_balance(balance)
    list = list ++ [command]
    {list, balance}
  end
end