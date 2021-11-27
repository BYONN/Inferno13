/obj/effect/spawner/regenlootdrop
	name = "regenerative spawner - DO NOT USE THIS"
	icon_state = "random_loot_regen"
	icon = 'icons/effects/landmarks_static.dmi'
	layer = OBJ_LAYER
	invisibility = INVISIBILITY_ABSTRACT
	var/spawn_on_turf = TRUE
	var/lootcount = 1		//how many items will be spawned
	var/lootdoubles = TRUE	//if the same item can be spawned twice
	var/list/loot			//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect)
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself

	var/regen_timer = 3 MINUTES
	var/viewed_regen_timer = 1 MINUTES //Don't spawn stuff if someone's looking
	var/regenerating = FALSE


/obj/effect/spawner/regenlootdrop/Initialize(mapload)
	..()
	if(loot && loot.len)
		drop_loot(TRUE)

/obj/effect/spawner/regenlootdrop/proc/drop_loot(forced = FALSE)
	var/atom/A = locate(/obj/structure/closet) in get_turf(src)
	if (!A)
		A = spawn_on_turf ? get_turf(src) : loc
	if (!forced)
		for (var/mob/living/carbon/human/H in fov_viewers(world.view, loc))
			if (H.client && H.stat != DEAD)
				addtimer(CALLBACK(regen_lootdrop, .proc/drop_loot), viewed_regen_timer)
	var/loot_spawned = 0
	var/list/possibilities = loot
	while((lootcount-loot_spawned) && possibilities.len)
		var/lootspawn = pickweight(possibilities)
		if(!lootdoubles)
			possibilities.Remove(lootspawn)

		if(lootspawn)
			var/atom/movable/spawned_loot = new lootspawn(A)
			spawned_loot.regen_lootdrop = src
			if (!fan_out_items)
				if (pixel_x != 0)
					spawned_loot.pixel_x = pixel_x
				if (pixel_y != 0)
					spawned_loot.pixel_y = pixel_y
			else
				if (loot_spawned)
					spawned_loot.pixel_x = spawned_loot.pixel_y = ((!(loot_spawned%2)*loot_spawned/2)*-1)+((loot_spawned%2)*(loot_spawned+1)/2*1)
			special_loot_act(spawned_loot)
		loot_spawned++
	if (istype(A, /obj/structure/closet))
		A:close()

/obj/effect/spawner/regenlootdrop/proc/special_loot_act(atom/movable/M)
	return