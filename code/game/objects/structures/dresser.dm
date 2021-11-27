/obj/structure/dresser
	name = "dresser"
	desc = "A nicely-crafted wooden dresser. It's filled with lots of undies."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "dresser"
	density = TRUE
	anchored = TRUE

/obj/structure/dresser/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wrench))
		to_chat(user, "<span class='notice'>You begin to [anchored ? "unwrench" : "wrench"] [src].</span>")
		if(I.use_tool(src, user, 20, volume=50))
			to_chat(user, "<span class='notice'>You successfully [anchored ? "unwrench" : "wrench"] [src].</span>")
			setAnchored(!anchored)
	else
		return ..()

/obj/structure/dresser/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/obj/structure/dresser/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	. = ..()
	if(. || !ishuman(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/mob/living/carbon/human/H = user

	if(H.dna && H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
		to_chat(H, "<span class='warning'>You are not capable of wearing underwear.</span>")
		return

	var/list/undergarment_choices = list("Underwear", "Undershirt", "Socks")

	var/choice = input(H, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in undergarment_choices
	if(!H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/datum/sprite_accessory/underwear/sprite_accessory
	var/obj/item/underwear/new_underwear
	var/color_choice
	switch(choice)
		if("Underwear")
			var/new_undies = input(H, "Select your underwear", "Changing") as null|anything in GLOB.underwear_list
			if(new_undies)
				sprite_accessory  = GLOB.underwear_list[new_undies]
		if("Undershirt")
			var/new_undershirt = input(H, "Select your undershirt", "Changing") as null|anything in GLOB.undershirt_list
			if(new_undershirt)
				sprite_accessory = GLOB.undershirt_list[new_undershirt]
		if("Socks")
			var/new_socks = input(H, "Select your socks", "Changing") as null|anything in GLOB.socks_list
			if(new_socks)
				sprite_accessory = GLOB.socks_list[new_socks]
	if(sprite_accessory)
		if(sprite_accessory.has_color)
			color_choice = recolor_undergarment(H)
		new_underwear = sprite_accessory.create_underwear(color_choice)
		if(new_underwear)
			new_underwear.loc = src.loc
			H.put_in_hands(new_underwear)

	add_fingerprint(H)

/obj/structure/dresser/proc/recolor_undergarment(mob/living/carbon/human/H)
	var/n_color = input(H, "Choose your garment's color.", "Character Preference", null) as color|null
	if(!n_color || !H.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return null
	return n_color