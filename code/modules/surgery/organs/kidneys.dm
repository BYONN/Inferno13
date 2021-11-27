/obj/item/organ/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_KIDNEYS
	desc = "Someone has graciously donated these."

	maxHealth = STANDARD_ORGAN_THRESHOLD
	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY

	high_threshold_passed = "<span class='warning'>You feel a stange ache in your abdomen, almost like a stitch. This pain is encumbering your movements.</span>"
	high_threshold_cleared = "<span class='notice'>The stitching ache in your abdomen passes away, unencumbering your movements.</span>"
	now_fixed = "<span class='notice'>The stabbing pain in your abdomen slowly calms down into a more tolerable ache.</span>"

	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/iron = 5)
	var/obj/item/reagent_containers/bladder

/obj/item/organ/kidneys/Initialize(mapload)
	. = ..()
	bladder = new /obj/item/reagent_containers(src)
	bladder.create_reagents(50)

/obj/item/organ/kidneys/on_life()
	. = ..()
	if (!. || !owner)
		return

	if (bladder)
		switch (bladder.reagents.total_volume)
			if (49 to INFINITY)
				to_chat(owner, "<span class='warning'>You can't hold it anymore!</span>")
				owner.mob_urinate(TRUE)
			if (45 to 49)
				if (prob(5))
					to_chat(owner, "<span class='warning'>You really have to pee!</span>")
			if (20 to 45)
				if (prob(2))
					to_chat(owner, "<span class='notice'>[pick("You could go for a leak.","A whizz would be nice right now.","You should visit a toilet.")]</span>")
		var/urine_modifier = 0.05
		switch (owner.water_level) //drink a lot of water piss a lot of piss
			if (THIRST_LEVEL_MIDDLE to THIRST_LEVEL_LIGHT)
				urine_modifier = 0.04
			if (THIRST_LEVEL_HARD to THIRST_LEVEL_MIDDLE)
				urine_modifier = 0.03
			if (THIRST_LEVEL_DEADLY to THIRST_LEVEL_HARD)
				urine_modifier = 0.02
			else
				urine_modifier = 0.01
		bladder.reagents.add_reagent(/datum/reagent/consumable/urine,urine_modifier)

	if(owner.getToxLoss())
		owner.adjustToxLoss(-0.1)