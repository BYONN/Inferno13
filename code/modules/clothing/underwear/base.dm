/obj/item/underwear
	w_class = WEIGHT_CLASS_TINY
	var/required_slot_flags
	var/required_free_body_parts
	var/sprite_acc
	var/covers_groin
	var/covers_chest

/obj/item/underwear/proc/worn_in_appropriate_slot(var/mob/living/carbon/human/H)
	return

obj/item/underwear/proc/is_slot_free(var/mob/living/carbon/human/H)
	return

/obj/item/underwear/afterattack(var/atom/target, var/mob/user, var/proximity)
	. = ..()
	if(!proximity)
		return // Might as well check
	DelayedEquipUnderwear(user, target)

/obj/item/underwear/MouseDrop(var/atom/target)
	DelayedEquipUnderwear(usr, target)

/obj/item/underwear/proc/CanEquipUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanAdjustUnderwear(user, H, "put on"))
		return FALSE
	if(H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
		to_chat(user, "<span class='warning'>\The [H]'s species cannot wear underwear of this nature.</span>")
		return FALSE
	if (!is_slot_free(H))
		to_chat(user, "<span class='warning'>\The [H] is already wearing underwear of this nature.</span>")
		return FALSE
	return TRUE

/obj/item/underwear/proc/CanRemoveUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanAdjustUnderwear(user, H, "remove"))
		return FALSE
	if(!worn_in_appropriate_slot(H))
		to_chat(user, "<span class='warning'>\The [H] isn't wearing \the [src].</span>")
		return FALSE
	return TRUE

/obj/item/underwear/proc/CanAdjustUnderwear(var/mob/user, var/mob/living/carbon/human/H, var/adjustment_verb)
	if(!istype(H))
		return FALSE
	if(user != H && !user.canUseTopic(H, BE_CLOSE))
		return FALSE

	if(H.get_covering_equipped_item(required_free_body_parts))
		to_chat(user, "<span class='warning'>Cannot [adjustment_verb] \the [src]. There's something in the way.</span>")
		return FALSE

	return TRUE

/obj/item/underwear/proc/DelayedRemoveUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return
	if(user != H)
		visible_message("<span class='danger'>\The [user] is trying to remove \the [H]'s [name]!</span>")
		if(!do_after(user, strip_delay, target = H))
			return FALSE
	. = RemoveUnderwear(user, H)
	if(. && user != H)
		user.visible_message("<span class='warning'>\The [user] has removed \the [src] from \the [H].</span>", "<span class='notice'>You have removed \the [src] from \the [H].</span>")
		log_combat(user, H, "Removed underwear from", src)

/obj/item/underwear/proc/DelayedEquipUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return
	if(user != H)
		user.visible_message("<span class='warning'>\The [user] has begun putting on \a [src] on \the [H].</span>", "<span class='notice'>You begin putting on \the [src] on \the [H].</span>")
		if(!do_after(user, strip_delay, target = H))
			return FALSE
	. = EquipUnderwear(user, H)
	if(. && user != H)
		user.visible_message("<span class='warning'>\The [user] has put \the [src] on \the [H].</span>", "<span class='notice'>You have put \the [src] on \the [H].</span>")
		log_combat(user, H, "Put underwear on", src)

/obj/item/underwear/proc/EquipUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return FALSE
	if(!user.transferItemToLoc(src, user.loc))
		return FALSE
	return ForceEquipUnderwear(H)

/obj/item/underwear/proc/ForceEquipUnderwear(var/mob/living/carbon/human/H, var/update_icons = TRUE)
	// No matter how forceful, we still don't allow multiples of the same underwear type
	if (!is_slot_free(H))
		return

	switch(type)
		if(/obj/item/underwear/top)
			H.undershirt = src
		if(/obj/item/underwear/bottom)
			H.underwear = src
		if(/obj/item/underwear/socks)
			H.socks = src
	forceMove(H)
	if(update_icons)
		H.update_body()

	return TRUE

/obj/item/underwear/proc/RemoveUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return FALSE

	switch(type)
		if(/obj/item/underwear/top)
			H.undershirt = null
		if(/obj/item/underwear/bottom)
			H.underwear = null
		if(/obj/item/underwear/socks)
			H.socks = null

	forceMove(H.loc)
	user.put_in_hands(src)
	H.update_body()

	return TRUE

/obj/item/underwear/verb/StripUnderwear()
	set name = "Remove Underwear"
	set category = "Object"
	set src in usr

	RemoveUnderwear(usr, usr)

/obj/item/underwear/socks
	required_free_body_parts = FEET

/obj/item/underwear/socks/worn_in_appropriate_slot(var/mob/living/carbon/human/H)
	if(H.socks == src)
		return TRUE

/obj/item/underwear/socks/is_slot_free(var/mob/living/carbon/human/H)
	if(!H.socks)
		return TRUE

/obj/item/underwear/top
	required_free_body_parts = CHEST

/obj/item/underwear/top/worn_in_appropriate_slot(var/mob/living/carbon/human/H)
	if(H.undershirt == src)
		return TRUE

/obj/item/underwear/top/is_slot_free(var/mob/living/carbon/human/H)
	if(!H.undershirt)
		return TRUE

/obj/item/underwear/bottom
	required_free_body_parts = FEET|LEGS|GROIN

/obj/item/underwear/bottom/worn_in_appropriate_slot(var/mob/living/carbon/human/H)
	if(H.underwear == src)
		return TRUE

/obj/item/underwear/bottom/is_slot_free(var/mob/living/carbon/human/H)
	if(!H.underwear)
		return TRUE

/obj/item/underwear/undershirt
	required_free_body_parts = CHEST

/datum/sprite_accessory/underwear/proc/create_underwear(var/chosen_color)
	if(!underwear_type)
		return

	var/obj/item/underwear/UW = new underwear_type()
	UW.name = name
	UW.sprite_acc = src
	UW.gender = gender
	UW.icon = icon
	UW.icon_state = icon_state
	UW.covers_groin = covers_groin
	UW.covers_chest = covers_chest
	UW.color = chosen_color

	return UW