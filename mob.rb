#!/usr/bin/env ruby

require 'digest'

class Mob

	ALLOWANCE = 1.0
	HASH_MOD = 999999
	FUZZ_MOD = 1000
	FUZZNESS = 0.15
	ATTR_LIMIT = FUZZ_MOD

	attr_accessor :name, :hp, :seed, :str, :dex, :sta

	def initialize(name)

		# Initialise the name and seed based on name
		@name = name
		@seed = Digest::SHA256.hexdigest(@name).to_i(16) % HASH_MOD
		@hp = 1.0

		# Grab values from seed and fuzz by 10%
		h1 = @seed.to_s[0..2].to_f * (rand * (2.0 * FUZZNESS) + (1.0 - FUZZNESS)) % FUZZ_MOD / ATTR_LIMIT
		h2 = @seed.to_s[3..5].to_f * (rand * (2.0 * FUZZNESS) + (1.0 - FUZZNESS)) % FUZZ_MOD / ATTR_LIMIT

		# begin attribute distribution
		pool = ALLOWANCE

		@str = pool*h1
		pool -= @str

		@dex = pool*h2
		pool -= @dex

		@sta = pool
	end

	def dead?
		return @hp <= 0
	end

	def to_s
		return "#{@name} : HP:#{@hp} str:#{@str} dex:#{@dex} sta:#{@sta}"
	end

end
