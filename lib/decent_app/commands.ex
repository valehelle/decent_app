defmodule DecentApp.Commands do


  #1. import the Config
  #2. from the given commmand, list balance , I would iterate the config list with all the param
  #3. once we found the command, check the balance , check the validation_rules
  #4. if pass, execute the function.
  
   
    alias DecentApp.Config

    def run(cmd, res, balance) do

        command = find_command(cmd) |> find_command_from_criteria()
        if(command) do
          balance = apply_balance(balance, command.price)
          validation_rules = command.validation_rules
          if balance > 0 do
            #check for the validation rules
            is_valid = Enum.all?(validation_rules, fn rule -> 
            {comp, num} = rule.value
            {result, _} = Code.eval_string("#{rule.type}(a) #{comp} #{num}", [a: res], __ENV__) 
            result
            end)
          
            if is_valid do
              new_list = command.perform.(res, cmd)
              {balance, new_list, false}
            else
              {nil, nil, true}
            end
          else
            {nil, nil, true}
          end
        else
          {nil, nil, true}
        end
        
    end


    def find_command_from_criteria(result) do
      case result do
      {:ok, cmd} ->
        cmd
      {:error, cmd} ->
        configs = Config.get()
        config_with_criterias = Enum.filter(configs, fn config -> Map.has_key?(config, :criteria) end)
        command =  Enum.find(config_with_criterias, fn config -> 
                      Enum.find(config.criteria, fn criteria -> criteria == cmd end)
                      
                    end)
        command
      end
    end

    def find_command(cmd) do
      configs = Config.get()
      command =  Enum.find(configs, fn config -> config.name == cmd end)
      if command != nil do
        {:ok, command}
      else
        {:error, cmd}
      end
      
    end

    def apply_balance(balance, price) do
      %{balance | coins: balance.coins - price}
    end

end