/obj/machinery/shop_rack
	name = "shop rack"
	desc = "Lined full with goodies. There's a bin attached with cards, and a card puncher assembly."

	icon = 'icons/WVM/shop_rack.dmi'
	icon_state = "rack"

	anchored = TRUE
	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = BELOW_OBJ_LAYER

	var/list/goods = list()
	var/store

/datum/data/shopping_good
	var/product_name = "generic"
	var/product_path = null
	var/cost = 0

/datum/data/shopping_good/New(name, path, cost)
	src.product_name = name
	src.product_path = path
	src.cost = cost

/obj/machinery/shop_rack/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Vendor goods:</b><BR><table border='0' width='300'>"
	for (var/datum/data/shopping_good/entry in goods)
		dat += "<tr><td>[entry.product_name]</td><td>[entry.cost]</td><td><A href='?src=[REF(src)];order=[REF(entry)]'>Order</A></td><td><A href='?src=[REF(src)];cancel=[REF(entry)]'>Cancel</A></td></tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "shoprack", "Shop Rack", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/shop_rack/attackby(obj/item/OtherItem, mob/living/carbon/human/user, parameters)
	attack_hand(user)

/obj/machinery/shop_rack/Topic(href, href_list)
	if (..())
		return
	if (href_list["order"])
		var/datum/data/shopping_good/entry = locate(href_list["order"])
		if (!entry || !entry.product_path)
			to_chat(usr, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if (ishuman(usr))
			var/mob/living/carbon/human/H = usr
			var/obj/item/held = H.get_active_held_item()
			if (held && istype(held, /obj/item/shopping_card))
				if (held:authenticator)
					to_chat(usr, "<span class='warning'>You slot your card into the puncher, and it spits it back out. It's already authenticated!</span>")
					return
				if (held:store != store)
					to_chat(usr, "<span class='warning'>You slot your card into the puncher, and it spits it back out. It's for another store!</span>")
					return
				held:add_to_cart(entry.product_path, entry.product_name, entry.cost)
				to_chat(usr, "<span class='notice'>You slot your card in and punch in your choice.</span>")
			else
				var/obj/item/shopping_card/new_card = new /obj/item/shopping_card(loc)
				new_card.add_to_cart(entry.product_path, entry.product_name, entry.cost)
				new_card.store = store
				to_chat(usr, "<span class='notice'>You take a card from the bin and let the puncher add your choice to the card.</span>")
				H.put_in_active_hand(new_card)
	if (href_list["cancel"])
		var/datum/data/shopping_good/entry = locate(href_list["cancel"])
		if (!entry || !entry.product_path)
			to_chat(usr, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if (ishuman(usr))
			var/mob/living/carbon/human/H = usr
			var/obj/item/held = H.get_active_held_item()
			if (held && istype(held, /obj/item/shopping_card))
				if (held:authenticator)
					to_chat(usr, "<span class='warning'>You slot your card into the puncher, and it spits it back out. It's already authenticated!</span>")
					return
				if (held:store != store)
					to_chat(usr, "<span class='warning'>You slot your card into the puncher, and it spits it back out. It's for another store!</span>")
					return
				if (held:remove_from_cart(entry.product_path, entry.cost))
					to_chat(usr, "<span class='notice'>You slot your card in, and it comes back out with less punches.</span>")
				else
					to_chat(usr, "<span class='warning'>You slot your card in, and it comes back out with the same number of punches. Huh.</span>")
			else
				to_chat(usr, "<span class='warning'>Maybe try having a card to cancel your order from. Dumbass.</span>")
				return
	updateUsrDialog()
	return

/obj/item/shopping_card
	name = "shopping card"
	desc = "There's no actual words on it, apart from the store logo on the back. There's just a bunch of columns and rows with numbers, and some holes in seemingly random places."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "punchcard"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 50
	var/store //string
	var/mob/living/carbon/human/authenticator
	var/total
	var/list/goods = list()

/obj/item/shopping_card/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		. += "<span class='warning'>You're too far away to have a good look at it!</span>"
		return
	var/shopping_list = "Your wristpad acknowledges the card, which corresponds to products from [store]: "
	var/list/strings = list()
	for (var/list/entry in goods)
		var/entry_text = ""
		entry_text += "[entry["item_name"]]"
		entry_text += " x[num2text(entry["quantity"])]"
		entry_text += " ($[num2text(entry["quantity"]*entry["price"])])"
		strings += entry_text
	shopping_list += english_list(strings)

	. += "[shopping_list]. The total is <b>$[total]</b>."
	if(authenticator)
		. += "<span class='notice'>It bears a creditchip signature.</span>"

/obj/item/shopping_card/proc/add_to_cart(var/item_path, var/item_name, var/price)
	playsound(loc, 'sound/effects/punchcard.ogg', 50, 1)
	for (var/list/entry in goods)
		if (entry["item_path"] == item_path)
			entry["quantity"]++
			total += price
			return
	var/list/new_entry = list()
	new_entry["item_path"] = item_path
	new_entry["item_name"] = item_name
	new_entry["price"] = price
	new_entry["quantity"] = 1
	goods.len++
	goods[goods.len] = new_entry
	total += price

/obj/item/shopping_card/proc/remove_from_cart(var/item_path, var/price)
	for (var/list/entry in goods)
		if (entry["item_path"] == item_path)
			entry["quantity"]--
			total -= price
			playsound(loc, 'sound/effects/punchcard.ogg', 50, 1)
			if (entry["quantity"] <= 0)
				qdel(entry)
			return TRUE