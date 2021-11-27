/mob/living/simple_animal/snm
	name = "supernumerary"
	desc = "An inconsequential extra."
	icon = 'icons/mob/supernumerary.dmi'
	icon_state = "male"
	icon_living = "male"
	icon_dead = "male"
	status_flags = GODMODE
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2)
	stop_automated_movement = 1

/mob/living/simple_animal/snm/interactible
	var/interacting = FALSE

/mob/living/simple_animal/snm/interactible/on_attack_hand(mob/living/carbon/human/M)
	if(stat != DEAD && M.a_intent == INTENT_HELP)
		snm_interacted(M)
	else
		..()

/mob/living/simple_animal/snm/interactible/proc/snm_interacted(mob/living/carbon/human/M)
	return

/mob/living/simple_animal/snm/interactible/lance
	name = "Lance"
	desc = "The man in charge of the meat factory. Seems to just be lazing about."
	icon_state = "lance"
	icon_living = "lance"
	icon_dead = "lance"
	anchored = TRUE
	var/list/beggars = list()

/mob/living/simple_animal/snm/interactible/lance/snm_interacted(mob/living/carbon/human/M)
	if (M in beggars)
		say("Hey! I'm not running a charity here. You're not getting anymore handouts from me.")
		return
	if (interacting)
		return
	interacting = TRUE
	say("You must be a new clone. Welcome to the meat factory. Hey, how about a job? There's plenty of defective clones that need...  processing.")
	spawn (50)
		if (!M.canUseTopic(src, BE_CLOSE))
			say("Guess you're too good for it, huh? Fine, suit yourself.")
			interacting = FALSE
			return
		var/obj/item/gun/ballistic/revolver/rusty/garbage = new /obj/item/gun/ballistic/revolver/rusty(src)
		M.put_in_hands(garbage)
		M.payact(100)
		M.visible_message("<span class='notice'>[src] rummages around his pockets, producing a rusty revolver that he hands to [M], then waves his credchip over the latter's.</span>", \
			"<span class='notice'>[src] rummages around in his pockets, producing a rusty revolver that he hands to you, then waves his credchip over yours.</span>")
		say("Here, you'll need this. It's not much, but hey, it's free. Here's some scratch for more ammo, too. Every defective you knock off is a load off my back, and pay for you.")
		beggars += M
		interacting = FALSE

/mob/living/simple_animal/snm/interactible/bartender/lechuck