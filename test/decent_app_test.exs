defmodule DecentAppTest do
  use ExUnit.Case
  doctest DecentApp

  alias DecentApp.Balance

  describe "Awesome tests" do
    test "success" do
      balance = %Balance{coins: 10}

      {new_balance, result} =
        DecentApp.call(balance, [3, "DUP", "COINS", 5, "+", "NOTHING", "POP", 7, "-", 9, 1,"*"])

      assert new_balance.coins == 1
      assert result == [36]
    end
    
    test "DUP should duplicate the last item in the result list and cost 1 coin" do
      balance = %Balance{coins: 10}

      {new_balance, result} =
        DecentApp.call(balance, [4, 5, 3, "DUP"])

      assert result === [4, 5, 3, 3]
      assert new_balance.coins == 6
    end

    test "POP cuts the last item in the result list and cost 1 coin" do
      balance = %Balance{coins: 10}

      {new_balance, result} =
        DecentApp.call(balance, [4, 5, 3, "POP"])

      assert result === [4, 5]
      assert new_balance.coins == 6
    end

    test "+ adds up two last items in the result list and replaces them with the result of addition and cost 2 coin" do
      balance = %Balance{coins: 10}

      {new_balance, result} =
        DecentApp.call(balance, [4, 5, 3, "+"])

      assert result === [4, 8]
      assert new_balance.coins == 5
    end

    test "- subtracts the second last number from the last and replaces them with the result of the difference and cost 1 coin" do
      balance = %Balance{coins: 10}

      {new_balance, result} =
        DecentApp.call(balance, [4, 3, 8, "-"])

      assert result === [4, 5]
      assert new_balance.coins == 6
    end

    test "* takes 3 last items from the list, multiply them and replaces them with the result and cost 3 coin" do
      balance = %Balance{coins: 10}

      {new_balance, result} =
        DecentApp.call(balance, [1, 4, 3, 8, "*"])

      assert result === [1, 96]
      assert new_balance.coins == 3
    end

    test "failed" do
      assert DecentApp.call(%Balance{coins: 10}, [
               3,
               "DUP",
               "FALSE",
               5,
               "+",
               "NOTHING",
               "POP",
               7,
               "-",
               9
             ]) == -1

      assert DecentApp.call(%Balance{coins: 1}, [3, 5, 6]) == -1
      assert DecentApp.call(%Balance{coins: 10}, ["+"]) == -1
      assert DecentApp.call(%Balance{coins: 10}, ["-"]) == -1
      assert DecentApp.call(%Balance{coins: 10}, ["DUP"]) == -1
      assert DecentApp.call(%Balance{coins: 10}, ["POP"]) == -1
      assert DecentApp.call(%Balance{coins: 10}, [1, 4, "UNKNOWN"]) == -1
    end
  end
end
