require './mob.rb'

class Battle

	attr_accessor :m1, :m2

	def initialize(m1, m2)
		@m1 = m1
		@m2 = m2
	end

	def start

		#set seed
		srand

		#begin round, so long as no one is dead
		until m1.dead? or m2.dead?

			# set who goes in this round
			attacker = (rand < 0.5) ? m1 : m2
			defender = (attacker == m1) ? m2 : m1

			output = ""

			# enough stamina to attack?
			if rand <= attacker.sta

				output += "#{attacker.name} takes a swing, "

				# does the defender dodge it?
				if rand <= defender.dex

          output += "but #{defender.name} dodges out of the way!"
				else
					# it connects!
					output += "and connects with #{("%0.2f" % attacker.str).to_f} damage!"
					defender.hp -= attacker.str
				end
			end
		
			puts output if output != ""
		end

		puts "The winner is #{(m1.dead?)? m2 : m1}!"
		puts "---"
		puts "Final stats:"
		puts m1
		puts m2

	end

end
