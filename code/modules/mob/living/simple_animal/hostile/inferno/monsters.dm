/mob/living/simple_animal/hostile/lobstrosity
	name = "lobstrosity"
	desc = "A giant crustacean creature, with deadly snapping claws to match."
	icon_state = "lobstrosity"
	icon_living = "lobstrosity"
	icon_dead = "lobstrosity_d"
	speed = 1
	icon_gib = "gib"
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/lobstrosity = 2, /obj/item/stack/sheet/sinew = 1)
	maxHealth = 150
	health = 150
	melee_damage_lower = 20
	melee_damage_upper = 30
	blood_volume = 0
	ranged_message = "snaps"
	projectiletype = /obj/item/projectile/melee
	projectile_name = "claw"
	melee_damage_type = SLASH