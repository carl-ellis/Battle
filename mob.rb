class Mob

	ALLOWANCE = 1.0

	attr_accessor :name, :hp, :seed, :str, :dex, :sta

	def initialize(name)

		# Initialise the name and seed based on name
		@name = name
    		@seed = @name.hash
		@hp = 1.0

		# Set random seed
		srand(@seed)

		# begin attribute distribution
		pool = ALLOWANCE

		@str = pool*rand
		pool -= @str

		@dex = pool*rand
		pool -= @dex

		@sta = pool
	end

	def dead?
		return hp <= 0
	end

	def to_s
		return "#{@name} : HP:#{@hp} str:#{@str} dex:#{@dex} sta:#{@sta}"
	end

end
