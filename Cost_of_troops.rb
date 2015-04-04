# Input: strings copy and pasted from http://clashofclans.wikia.com/wiki/Unit_Calculators
def wiki_table_to_data(wiki_table_string)
	rows = wiki_table_string.
	        split("\n").
	        map{|x| x.gsub('Wall Breaker','wallbreaker').
	            gsub('Hog Rider','hogrider').
	            gsub('Lava Hound','lavahound')
	        }
	split_rows = rows.map{|x| x.split}.select{|x| !x.empty?}
        Hash[split_rows.map{|x|
            troop = x.first.gsub(/\W/,'').downcase
            costs = x[1..-1].map{|c| c.gsub(",","").to_i}
            [troop,costs]
        }]
end

def elixir_cost
	wiki_table_to_data( %Q{
	    Barbarian    25    40    60    80    100    150    200
	    Archer    50    80    120    160    200    300    400
	    Goblin    25    40    60    80    100    150    -
	    Giant    250    750    1,250    1,750    2,250    3,000    3,500
	    Wall Breaker    1,000    1,500    2,000    2,500    3,000    3,500    -
	    Balloon    2,000    2,500    3,000    3,500    4,000    4,500    -
	    Wizard    1,500    2,000    2,500    3,000    3,500    4,000    -
	    Healer    5,000    6,000    8,000    10,000    -    -    -
	    Dragon    25,000    30,000    36,000    42,000    -    -    -
	    P.E.K.K.A    30,000    35,000    40,000    45,000    50,000    -
	} )
end

def dark_elixir_cost
	wiki_table_to_data( %Q{
		Minion	6    7    8    9    10    11
		Hog Rider    40    45    52    58    65    -
		Valkyrie    70    100    130    160    -    -
		Golem    450    525    600    675    750    -
		Golemite    0    0    0    0    0    -
		Witch    250    350    -    -    -    -
		Skeleton    0    -    -    -    -    -
		Lava Hound    390    450    510    -    -    -
		Lava Pup    0    -    -    -    -    -
       })
end

def army_camp_cost
	wiki_table_to_data( %Q{
		Barbarian    1    1    1    1    1    1    1
		Archer    1    1    1    1    1    1    1
		Goblin    1    1    1    1    1    1    -
		Giant    5    5    5    5    5    5    5
		Wall Breaker    2    2    2    2    2    2    -
		Balloon    5    5    5    5    5    5    -
		Wizard    4    4    4    4    4    4    -
		Healer    14    14    14    14    -    -    -
		Dragon    20    20    20    20    -    -    -
		P.E.K.K.A    25    25    25    25    25    -    -
		Minion    2    2    2    2    2    2    -
		Hog Rider    5    5    5    5    5    -    -
		Valkyrie    8    8    8    8    -    -    -
		Golem    30    30    30    30    30    -    -
		Witch    12    12    -    -    -    -    -
		Lava Hound    30    30    30    -    -    -
        })
end


def time_cost
	barracks_time_cost = {
		'barbarian' => [20]*7,
		'archer' => [25]*7,
		'goblin' => [30]*7,
		'giant'  => [2*60]*7,
		'wallbreaker' => [2*60]*7,
		'balloon' => [8*60]*7,
		'wizard' => [8*60]*7,
		'healer' => [15*60]*7,
		'dragon' => [30*60]*7,
		'pekka' => [45*60]*7,
		}
end

def dark_time_cost
	dark_time_cost = {
		'minion'    => [45]*8,
		'hogrider'  => [2*60]*8,
		'valkyrie'  => [8*60]*8,
		'golem'     => [45*60]*8,
		'witch'	    => [20*60]*8,
		'lavahound' => [45*60]*8,
	}
end

def get_cost(costs,troop,level)
	    cost_for_troop = costs[troop]
	    return 0 unless cost_for_troop	    
	    cost_for_troop[level.to_i - 1]
end

def nice_time(total_time)
	"%d:%02d:%02d" % [total_time / 60 /60 , total_time / 60 % 60, total_time % 60]
end


def show_costs(army_description)
	
	army = army_description.scan(/([0-9]+) [Ll]([0-9]+) ([a-z]+)/)
	total_elixir_cost = 0
	total_dark_elixir_cost = 0
	total_time = 0
	total_army_camp = 0
	army_output = []

	army.each{|number,level,troops|
		troop = troops.sub(/s$/,"")

		dark_elixir_for_one = get_cost(dark_elixir_cost,troop,level)
		elixir_for_one = get_cost(elixir_cost,troop,level)	    
		time_for_one = get_cost(time_cost,troop,level)	    
		army_camp_for_one = get_cost(army_camp_cost,troop,level)
		
		next if army_camp_for_one == 0
		
		army_output << "#{number} L#{level} #{troops}"

		total_elixir_cost = total_elixir_cost + elixir_for_one * number.to_i
		total_dark_elixir_cost = total_dark_elixir_cost + dark_elixir_for_one * number.to_i
		total_time = total_time + time_for_one * number.to_i
		total_army_camp += army_camp_for_one * number.to_i

		elixir_for_all = elixir_for_one * number.to_i
		dark_elixir_for_all = dark_elixir_for_one * number.to_i
	
	}

	puts "%7d elixir, %5d dark, %3d space, %s barracks time for: %s " %
	     [total_elixir_cost, total_dark_elixir_cost, total_army_camp, nice_time(total_time / 4), army_output.join(", "),]

end

#show_costs("50 L5 barbarians, 25 L4 wizards, and 50 L4 archers")
#show_costs("12 L5 balloons, 70 L4 barbarian, and 70 L4 archers")
#show_costs("16 L5 balloons, and 70 L4 archers, and 25 L2 minions")
#show_costs("20 L5 balloons, and 50 L2 minions")
#show_costs("42 L5 barbarians, 25 L4 wizards, 1 L1 valkyrie, and 50 L4 archers")
#show_costs("62 L4 barbarians, 72 L4 archers, and 33 L2 minions")
#show_costs("62 L5 barbarians, 72 L4 archers, and 33 L2 minions")
#show_costs("200 L5 barbarians")
#show_costs("26 L5 balloons, and 35 L4 minions")
show_costs("2 l1 golems 3 L1 witch 16 L5 barbarian 16 L5 archer 10 L5 wallbreaker 18 L5 wizard")
show_costs("50 l4 minions 20 l6 balloons")
