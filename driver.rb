require './battle.rb'

m1 = Mob.new("carl")
m2 = Mob.new("maya")

b = Battle.new(m1, m2)
b.start
