local module = {}

module.Troops = {
	"Soldier",
	"Pyro"
}

module.TroopsStats = {
	Soldier = {Attack = 2, Firerate = 0.3, Range = 30, HireCost = 150, Cost = "Free", Health = 10},
	Pyro = {Attack = 1, Firerate = 0.1, Range = 15, HireCost = 350, Cost = 300, Health = 15}
}

return module
