
elixir_cost = {
	'barbarian' => 100,
	'archer' => 120
}


all_troop_names = elixir_cost.keys

all_troop_names.each{ |troop|
	puts " A " + troop + " costs " + 
		elixir_cost[troop].to_s  + 
		" elixir!"
	}
