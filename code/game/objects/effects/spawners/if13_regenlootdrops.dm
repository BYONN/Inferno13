/obj/effect/spawner/regenlootdrop/if13/meds
	name = "meds regenerative"

	loot = list(
				/obj/item/reagent_containers/hypospray/medipen/nanite = 10,
				/obj/item/stack/medical/gauze = 35,
				/obj/item/stack/medical/suture = 35,
				/obj/item/stack/medical/ointment = 20,
				)

/obj/effect/spawner/regenlootdrop/if13/money
	name = "money regenerative"
	var/money_max
	var/money_min

	loot = list(/obj/item/holochip)

/obj/effect/spawner/regenlootdrop/if13/money/special_loot_act(obj/item/holochip/holo)
	holo.credits = rand(money_min, money_max)
	if (prob(75)) //Will most of the time be a multiple of 5, but there's always going to be a weirdo stashing 98 bucks
		holo.credits = round(holo.credits,5)
	holo.update_icon()

/obj/effect/spawner/regenlootdrop/if13/money/low
	money_max = 100
	money_min = 25