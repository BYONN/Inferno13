/obj/machinery/shop_counter
	name = "shop counter"
	desc = "This is where you pay for and pick up your order. Keep your creditchip handy!"

	icon = 'icons/obj/economy.dmi'
	icon_state = "counter"

	anchored = TRUE
	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = BELOW_OBJ_LAYER

	var/store
	var/bag_icon

	var/list/bought_objects
	var/list/unwanted_objects

/obj/machinery/shop_counter/attackby(obj/item/W, mob/user, params)
	if (!(ishuman(user)))
		return
	if (istype(W, /obj/item/shopping_card))
		var/obj/item/shopping_card/card = W
		if (card.store != store)
			to_chat(usr, "<span class='warning'>This card is for another store! You look like a real fool.</span>")
			return
		if (!(card.authenticator))
			to_chat(usr, "<span class='warning'>This card isn't authenticated. Slot it into your wristpad to approve it.</span>")
			return
		if (!user:canpay(card.total))
			to_chat(usr, "<span class='warning'>You can't afford it, you bum!</span>")
			return
		to_chat(usr, "<span class='notice'>You pay for your purchase and get a bag with your stuff inside.</span>")
		user:payact(-card.total)
		var/obj/item/storage/box/shopping_bag/bag = new /obj/item/storage/box/shopping_bag(loc)
		for (var/list/entry in card.goods)
			var/path = entry["item_path"]
			for (var/i = 0, i<entry["quantity"], i++)
				new path(bag)
		bag.illustration = bag_icon
		bag.update_icon()
		user.put_in_hands(bag)
		qdel(card)
	else if (can_buy(W))
		to_chat(user, "<span class='notice'>You sell [W].</span>")
		user:payact(get_obj_value())
		qdel(W)
	else
		to_chat(usr, "<span class='warning'>The shop isn't interested in this.</span>")

/obj/machinery/shop_counter/proc/can_buy(obj/item/W)
	if (bought_objects.len)
		if (!W.get_obj_value())
			to_chat(usr, "<span class='warning'>[W] is worthless.</span>")
			return
		if (!(is_type_in_list(W, bought_objects)) || (unwanted_objects && is_type_in_list(W, unwanted_objects)))
			to_chat(usr, "<span class='warning'>This shop isn't interested in [W].</span>")
			return
		return TRUE