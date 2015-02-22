def dark_elixir_cost

dark_elixir_cost = {
	'valkyrie' => [70,100,130,160],
	}
	end

def elixir_cost

	elixir_cost = {
		'barbarian' => [25,40,60,80,100,150,200],
		'archer' => [50,80,120,160,200,300,400],
		'goblin' => [25,40,60,80,100,150],
		'wizard' => [1500,2000,2500,3000,3500,4000],
		'balloon' => [2000,2500,3000,3500,4000,4500],
		}
end

def get_cost(costs,troop,level)
	    cost_for_troop = costs[troop]
	    return 0 unless cost_for_troop	    
	    cost_for_troop[level.to_i - 1]
end

def show_costs(army_description)
	
	army = army_description.scan(/([0-9]+) L([0-9]+) ([a-z]+)/)
	total_elixir_cost = 0
	total_dark_elixir_cost = 0
	army.each{|number,level,troops|
		troop = troops.sub(/s$/,"")
		dark_elixir_for_one = get_cost(dark_elixir_cost,troop,level)
		elixir_for_one = get_cost(elixir_cost,troop,level)	    
		total_elixir_cost = total_elixir_cost + elixir_for_one * number.to_i
		total_dark_elixir_cost = total_dark_elixir_cost + dark_elixir_for_one * number.to_i
	
		elixir_for_all = elixir_for_one * number.to_i
		dark_elixir_for_all = dark_elixir_for_one * number.to_i
	
	
	}
	puts "The cost of\n #{army_description} is\n #{total_elixir_cost} elixir and #{total_dark_elixir_cost} dark elixir."	
end
show_costs("50 L5 barbarians, 25 L4 wizards, and 50 L4 archers")
show_costs("8 L5 balloons, 80 L4 barbarian, and 80 L4 archers")
show_costs("12 L5 balloons, 70 L4 barbarian, and 70 L4 archers")
show_costs("12 L5 balloons, 20 L4 barbarian, and 50 L4 archers")
show_costs("42 L5 barbarians, 25 L4 wizards, 1 L1 valkyrie, and 50 L4 archers")
