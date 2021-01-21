defmodule DecentApp do
  alias DecentApp.Balance
  alias DecentApp.Operation

  def call(%Balance{} = balance, commands) do
    {balance, result, error} =
      Enum.reduce(commands, {balance, [], false}, fn command, {bal, res, error} ->
        if error do
          {nil, nil, true}
        else
            {new_balance, res, is_error} = Operation.apply_command(command, res, bal)
        end
      end)

    if error || balance.coins < 0 do
      -1
    else
      {balance, result}
    end
  end
end
