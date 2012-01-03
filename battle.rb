#!/usr/bin/env ruby

require './mob.rb'

class Battle

	ATTACK_ATTEMPT = " takes a swing, "
	DODGE_SUCCESS_1 = "but "
	DODGE_SUCCESS_2 = " dodges out of the way!\n"
	ATTACK_SUCCESS_1 = "and connects with "
	ATTACK_SUCCESS_2 = " damage!\n"

	attr_accessor :m1, :m2, :log

	def initialize(m1, m2)
		@m1 = m1
		@m2 = m2
	end

	def fight

		#clear log
		@log = ""

		#set seed
		srand

		#begin round, so long as no one is dead
		until m1.dead? or m2.dead?

			# set who goes in this round
			attacker = (rand < 0.5) ? m1 : m2
			defender = (attacker == m1) ? m2 : m1

			# enough stamina to attack?
			if rand <= attacker.sta

				@log << "#{attacker.name}#{ATTACK_ATTEMPT}"

				# does the defender dodge it?
				if rand <= defender.dex

          				@log << "#{DODGE_SUCCESS_1}#{defender.name}#{DODGE_SUCCESS_2}"
				else
					# it connects!
					@log << "#{ATTACK_SUCCESS_1}#{("%0.2f" % attacker.str).to_f}#{ATTACK_SUCCESS_2}"
					defender.hp -= attacker.str
				end
			end
		end
	end

	def results

		output = "";
		output << @log
		output << "The winner is #{(m1.dead?)? m2.name : m1.name}!\n"
		output << "---\n"
		output << "Final stats:\n"
		output << "#{m1}\n"
		output << "#{m2}\n"
		return output
	end

end
