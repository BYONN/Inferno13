/mob/living/carbon/verb/urinate_verb()
	set category = "IC"
	set name = "Urinate"
	set desc = "Let it go."
	mob_urinate()

/mob/living/carbon/proc/mob_urinate(var/forced = FALSE)
	var/obj/item/organ/kidneys/kidneys = getorganslot(ORGAN_SLOT_KIDNEYS)
	if (!(kidneys && kidneys.bladder))
		if (!forced)
			to_chat(src, "<span class='warning'>You... don't think you can piss. Like, at all.</span>")
		return
	var/obj/item/reagent_containers/bladder = kidneys.bladder
	if (bladder.reagents.total_volume < 10)
		if (!forced)
			to_chat(src, "<span class='notice'>You don't need to right now.</span>")
		return
	var/obj/structure/toilet/T = locate(/obj/structure/toilet) in loc
	var/obj/structure/urinal/U = locate(/obj/structure/urinal) in loc
	if ((T && T.open) || U)
		visible_message("<span class='notice'>[src] pisses into [U ? U : T] with a soft tinkle.</span>","<span class='notice'>You piss into [U ? U : T] with a soft tinkle.</span>")
		bladder.reagents.remove_reagent(/datum/reagent/consumable/urine,10)
		return
	else
		if(forced)
			visible_message("<span class='warning'>[src] pisses [p_them()]self!</span>","<span class='danger'>You piss yourself!</span>")
		else
			visible_message("<span class='notice'>[src] pisses on the ground.</span>","<span class='notice'>You piss on the ground.</span>")
		bladder.reagents.reaction(get_turf(src), TOUCH, 1, 0)
		bladder.reagents.remove_reagent(/datum/reagent/consumable/urine,10)