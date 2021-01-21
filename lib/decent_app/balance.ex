defmodule DecentApp.Balance do
  defstruct coins: 0

  def apply_balance(balance, coin \\ -1) do
    %{balance | coins: balance.coins + coin}
  end
end
