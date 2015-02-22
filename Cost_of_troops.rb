
def elixir_cost

	elixir_cost = {
		'barbarian' => [25,40,60,80,100,150,200],
		'archer' => [50,80,120,160,200,300,400],
		'goblin' => [25,40,60,80,100,150],
		'wizard' => [1500,2000,2500,3000,3500,4000],
		'balloon' => [2000,2500,3000,3500,4000,4500],
		}
end

def show_costs(army_description)
	
	army = army_description.scan(/([0-9]+) L([0-9]+) ([a-z]+)/)
	total_cost = 0
	army.each{|number,level,troops|
		troop = troops.sub(/s$/,"")
		cost_of_one = elixir_cost[troop][level.to_i - 1]
		total_cost = total_cost + cost_of_one * number.to_i
	
		cost_of_all = cost_of_one * number.to_i
	
		puts "The cost of a #{troop} is #{cost_of_one}, and " +
			"the cost of #{number} #{troops} is #{cost_of_all}."	
	}
	puts "The cost of your army is #{total_cost} elixir."	
end
#show_costs("50 L5 barbarians, 25 L4 wizards, and 50 L4 archers")
show_costs("8 L5 balloons, 80 L4 barbarian, and 80 L4 archers")
show_costs("12 L5 balloons, 70 L4 barbarian, and 70 L4 archers")
