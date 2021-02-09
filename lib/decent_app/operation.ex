defmodule DecentApp.Operation do


  
  @moduledoc """
  This is the Operation module.
  """

  @doc """
  Given command it will apply the appopriate function.

  Returns `{balance, list, is_error}`.

  ## Examples

      iex> DecentApp.Balance.apply_command("COINS", list, balance)
      {balance, list, is_error}

  """
  alias DecentApp.Balance


  def apply_command("COINS", list, balance) do
    balance = Balance.apply_balance(balance, 5)
    {balance, list, false}
  end

  def apply_command("NOTHING", list, balance) do
    balance = Balance.apply_balance(balance)
    {balance, list, false}
  end

  def apply_command("DUP", list, balance) when length(list) >= 1  do
    balance = Balance.apply_balance(balance)
    list = list ++ [List.last(list)]
    {balance, list, false}
  end

  def apply_command("POP", list, balance) when length(list) >= 1  do
    balance = Balance.apply_balance(balance)
    {_, list} = List.pop_at(list, length(list) - 1)
    {balance, list, false}
  end

  def apply_command("+", list, balance) when length(list) >= 2  do
    balance = Balance.apply_balance(balance, -2)
    [first, second | list] = Enum.reverse(list)
    
    list = Enum.reverse(list) ++ [first + second]
    {balance, list, false}
  end

  def apply_command("-", list, balance) when length(list) >= 2 do
    balance = Balance.apply_balance(balance)
    [first, second | list] = Enum.reverse(list)
    list = Enum.reverse(list) ++ [first - second]
    {balance, list, false}
  end

  def apply_command("*", list, balance) when length(list) >= 3  do
    balance = Balance.apply_balance(balance, -3)
    [first, second, third | list] = Enum.reverse(list)
    list = Enum.reverse(list) ++ [first * second * third]
    {balance, list, false}
  end
  

  def apply_command(command, list, balance) when is_integer(command) do
    balance = Balance.apply_balance(balance)
    list = list ++ [command]
    {balance, list, false}
  end

  def apply_command(_, _, _) do
    {nil, nil, true}
  end

end