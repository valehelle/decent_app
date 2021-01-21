defmodule DecentApp.Operation do

  def apply_command("COINS", list) do
    list
  end

  def apply_command("NOTHING", list) do
    list
  end

  def apply_command("DUP", list) do
    list ++ [List.last(list)]
  end

  def apply_command("POP", list) do
    {_, list} = List.pop_at(list, length(list) - 1)
    list
  end

  def apply_command("+", list)  do
    [first, second | list] = Enum.reverse(list)
    
    Enum.reverse(list) ++ [first + second]
  end

  def apply_command("-", list)do
    [first, second | list] = Enum.reverse(list)
    Enum.reverse(list) ++ [first - second]
  end

  def apply_command("*", list) do
    [first, second, third | list] = Enum.reverse(list)
    Enum.reverse(list) ++ [first * second * third]
  end

  def apply_command(command, list) when is_integer(command) do
    list ++ [command]
  end
end