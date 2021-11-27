/mob/living/simple_animal/hostile/retaliate/clone
	name = "defective clone"
	desc = "Another reject churned out by the clone tubes."
	gender = MALE
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "clone_1"
	icon_living = "clone_1"
	icon_dead = "clone_1"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	maxHealth = 60
	health = 60
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("clone")
	status_flags = CANPUSH
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2)
	ranged = TRUE
	ranged_message = "swings"
	projectiletype = /obj/item/projectile/melee
	projectile_name = "punch"
	check_friendly_fire = TRUE

/mob/living/simple_animal/hostile/retaliate/clone/female
	gender = FEMALE

/mob/living/simple_animal/hostile/retaliate/clone/Initialize()
	..()
	var/random = rand(1,6)
	if(gender == FEMALE)
		icon_living = "femclone_[random]"
	else
		icon_living = "clone_[random]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/retaliate/clone/death(gibbed)
	..()
	transform = turn(src.transform, 90)

/mob/living/simple_animal/hostile/retaliate/clone/revive(full_heal = 0, admin_revive = 0)
	. = ..()
	if (.)
		transform = turn(src.transform, -90)

/mob/living/simple_animal/hostile/humanoid
	gender = MALE
	icon = 'icons/mob/wastemobs.dmi'
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("nefarious")
	status_flags = CANPUSH
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2)
	ranged = TRUE
	ranged_message = "swings"
	projectiletype = /obj/item/projectile/melee
	projectile_name = "punch"

/mob/living/simple_animal/hostile/humanoid/death(gibbed)
	..()
	transform = turn(src.transform, 90)

/mob/living/simple_animal/hostile/humanoid/revive(full_heal = 0, admin_revive = 0)
	. = ..()
	if (.)
		transform = turn(src.transform, -90)

/mob/living/simple_animal/hostile/humanoid/crackhead
	name = "crackhead"
	desc = "Rotten yellow teeth accompanied by a crazed glazed gaze. Accompanied is too friendly of a word... Let's go with emboldened."
	icon_state = "crackhead_1"
	icon_living = "crackhead_1"
	icon_dead = "crackhead_1"
	maxHealth = 100
	health = 100
	harm_intent_damage = 20
	melee_damage_lower = 20
	melee_damage_upper = 20
	cash_loot_min = 0
	cash_loot_max = 30

/mob/living/simple_animal/hostile/humanoid/crackhead/Initialize()
	..()
	icon_living = "crackhead_[rand(1,3)]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/humanoid/crackhead/baseball
	ranged_message = "swings a bat"
	projectile_name = "baseball bat"
	weapon_overlay = "baseball"
	attack_sound = 'sound/weapons/genhit1.ogg'
	loot = list(/obj/item/twohanded/baseball)

/mob/living/simple_animal/hostile/humanoid/crackhead/crowbar
	ranged_message = "swings a crowbar"
	projectile_name = "crowbar"
	weapon_overlay = "crowbar"
	attack_sound = 'sound/weapons/genhit1.ogg'
	loot = list(/obj/item/crowbar/large)

/mob/living/simple_animal/hostile/humanoid/crackhead/knife
	ranged_message = "thrusts a knife"
	projectile_name = "kitchen knife"
	weapon_overlay = "knife"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	loot = list(/obj/item/kitchen/knife)
	melee_damage_type = STAB

/mob/living/simple_animal/hostile/humanoid/chud
	name = "chud"
	desc = "A lurching figure with greyish leathery skin. It seems to have been human once, surely it can be dispatched as easily as one."
	icon_state = "chud_1"
	icon_living = "chud_1"
	icon_dead = "chud_1"
	maxHealth = 120
	health = 120
	harm_intent_damage = 22
	melee_damage_lower = 22
	melee_damage_upper = 22
	ranged_message = "claws"
	projectile_name = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	emote_taunt = list("gnashes its teeth")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chud = 1, /obj/item/stack/sheet/animalhide/chud = 2)

/mob/living/simple_animal/hostile/humanoid/chud/Initialize()
	..()
	icon_living = "chud[rand(1,4)]"
	icon_dead = icon_living
	icon_state = icon_living