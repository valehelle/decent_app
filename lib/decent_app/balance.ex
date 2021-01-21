defmodule DecentApp.Balance do
  defstruct coins: 0
  @doc """
  Add or subtract balance based on input. Default value is -1.

  ## Examples

      iex> apply_balance(%Balance{coins: 10}, -5)
      %Balance{coins: 5}
  """
  def apply_balance(balance, coin \\ -1) do
    %{balance | coins: balance.coins + coin}
  end
end
