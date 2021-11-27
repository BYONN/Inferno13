/obj/machinery/menu
	name = "menu"
	desc = "A list of food and drinks served at the establishment, but you knew that, right?"

	icon = 'icons/obj/economy.dmi'
	icon_state = "menu"

	anchored = TRUE
	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = BELOW_OBJ_LAYER

	var/list/drinks = list()
	var/list/foods = list()
	var/mob/living/simple_animal/snm/interactible/bartender/barkeep

/datum/data/bar_drink
	var/product_name = "generic"
	var/drink_path = null
	var/cost = 0

/datum/data/bar_drink/New(name, path, cost)
	src.product_name = name
	src.drink_path = path
	src.cost = cost

/datum/data/bar_food
	var/product_name = "generic"
	var/food_path = null
	var/cost = 0

/datum/data/bar_food/New(name, path, cost)
	src.product_name = name
	src.food_path = path
	src.cost = cost

/obj/machinery/menu/can_interact(mob/user)
	if (ishuman(user) && (user in view()))
		return TRUE

/obj/machinery/menu/examine(mob/user)
	ui_interact(user)

/obj/machinery/menu/attackby(obj/item/I, mob/living/carbon/human/user, parameters)
	ui_interact(user)

/obj/machinery/menu/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Menu:</b><BR><table border='0' width='300'>"
	for (var/datum/data/bar_drink/entry in drinks)
		dat += "<tr><td>[entry.product_name]</td><td>[entry.cost]</td><td><A href='?src=[REF(src)];orderdrink=[REF(entry)]'>Order</A></td></tr>"
	for (var/datum/data/bar_food/entry in foods)
		dat += "<tr><td>[entry.product_name]</td><td>[entry.cost]</td><td><A href='?src=[REF(src)];orderfood=[REF(entry)]'>Order</A></td></tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "menu", "Menu", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/menu/Topic(href, href_list)
	if (..())
		return
	if (!ishuman(usr))
		return
	var/mob/living/carbon/human/H = usr
	if (href_list["orderdrink"])
		var/datum/data/bar_drink/entry = locate(href_list["orderdrink"])
		if (!entry || !entry.drink_path)
			to_chat(H, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if (!H.canpay(entry.cost))
			to_chat(H, "<span class='warning'>Come back when you can actually pay.</span>")
		H.payact(-entry.cost)
		var/obj/item/reagent_containers/food/drinks/drinkingglass/yourdrinksir = new /obj/item/reagent_containers/food/drinks/drinkingglass(loc)
		yourdrinksir.reagents.add_reagent (entry.drink_path, 50)
		H.put_in_active_hand(yourdrinksir)
		to_chat(H, "<span class='notice'>You receive your drink with extreme expediency.</span>")

	else if (href_list["orderfood"])
		var/datum/data/bar_food/entry = locate(href_list["orderfood"])
		if (!entry || !entry.food_path)
			to_chat(H, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if (!H.canpay(entry.cost))
			to_chat(H, "<span class='warning'>Come back when you can actually pay.</span>")
		H.payact(-entry.cost)
		var/obj/item/reagent_containers/food/yourfoodsir = new entry.food_path(loc)
		H.put_in_active_hand(yourfoodsir)
		to_chat(H, "<span class='notice'>You receive your meal with extreme expediency.</span>")
	updateUsrDialog()
	return