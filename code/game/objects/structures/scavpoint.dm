/obj/item/storage/scavpoint
	name = "pile of garbage"
	desc = "A pile of random stuff. Might be something good in it."
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "trash_1"
	anchored = TRUE
	density = FALSE
	var/list/loot_players = list()
	var/list/lootable_trash = list()
	var/list/garbage_list = list()
	var/rescavenge_time = 3 MINUTES

/obj/item/storage/scavpoint/proc/initialize_lootable_trash()
	garbage_list = get_loot_list()
	lootable_trash = list() //we are setting them to an empty list so you can't double the amount of stuff
	for(var/i in garbage_list)
		for(var/ii in i)
			lootable_trash += ii

/obj/item/storage/scavpoint/proc/get_loot_list()
	return list(GLOB.trash_ammo, GLOB.trash_chem, GLOB.trash_clothing, GLOB.trash_craft,
				GLOB.trash_gun, GLOB.trash_misc, GLOB.trash_money,
				GLOB.trash_part, GLOB.trash_tool)

/obj/item/storage/scavpoint/Initialize()
	. = ..()
	icon_state = "trash_[rand(1,3)]"
	GLOB.trash_piles += src
	initialize_lootable_trash()

/obj/item/storage/scavpoint/Destroy()
	GLOB.trash_piles -= src
	. = ..()

/obj/item/storage/scavpoint/attack_hand(mob/user)
	var/turf/ST = get_turf(src)
	if(user?.a_intent != INTENT_HARM)
		if(user in loot_players)
			to_chat(user, "<span class='notice'>You have already gone through [src] recently.</span>")
			return
		if(user.mind.skill_holder && do_after(user, 20, target = src))
			to_chat(user, "<span class='notice'>You scavenge through [src].</span>")
			var/scavmod = 1 + user.mind.get_skill_level(/datum/skill/level/scavenge)
			for(var/i=0, i<min(rand(max(scavmod-2,1),scavmod),5), i++)
				var/itemtype = pickweight(lootable_trash)
				if (itemtype)
					var/obj/item/item = new itemtype(ST)
					if(istype(item))
						item.from_trash = TRUE
			user.mind.auto_gain_experience(/datum/skill/level/scavenge, 10, 10000)
			loot_players += user
			addtimer(CALLBACK(src, .proc/rescavenge, user), rescavenge_time)
	else
		return ..()

/obj/item/storage/scavpoint/proc/rescavenge(mob/scavenger)
	if (scavenger)
		loot_players -= scavenger

GLOBAL_LIST_INIT(sewer_loot, list(
	/obj/item/reagent_containers/syringe = 5,
	/obj/item/treasure/trash/tincan = 5,
	/obj/item/treasure/trash/coffeepot = 1,
	/obj/item/geiger_counter = 1,
	/obj/item/treasure/trash/pipe = 4,
	/obj/item/toy/crayon/spraycan = 1,
	/obj/item/broken_bottle = 3
))

/obj/item/storage/scavpoint/sewer/get_loot_list()
	return list(GLOB.sewer_loot)