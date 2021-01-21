defmodule DecentApp do
  alias DecentApp.Balance
  alias DecentApp.Operation

  def call(%Balance{} = balance, commands) do
    {balance, result, error} =
      Enum.reduce(commands, {balance, [], false}, fn command, {bal, res, error} ->
        if error do
          {nil, nil, true}
        else
          is_error =
            cond do

              length(res) < 1 ->
                if command == "DUP" || command == "POP" || command == "+" || command == "-" || command == "*" do
                  true
                else
                  false
                end
              length(res) < 2 ->
                if command == "+" || command == "-" || command == "*" do
                  true
                else
                  false
                end

              is_integer(command) ->
                if command < 0 || command > 10 do
                  true
                else
                  false
                end

              command != "NOTHING" && command != "DUP" && command != "POP" && command != "+" &&
                command != "-" && command != "*" && command != "COINS" && !is_integer(command) ->
                true

              true ->
                false
            end
          if is_error do
            {nil, nil, true}
          else
            {res, new_balance} = Operation.apply_command(command, res, bal)
            {new_balance, res, false}
          end
        end
      end)

    if error do
      -1
    else
      if balance.coins < 0 do
        -1
      else
        {balance, result}
      end
    end
  end
end
