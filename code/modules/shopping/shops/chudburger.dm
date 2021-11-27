/obj/machinery/shop_counter/chudburger
	store = "Chud Burger"
	bag_icon = "chudburger"
	bought_objects = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/chud
		)

/obj/machinery/shop_rack/chudburger
	store = "Chud Burger"

/obj/machinery/shop_rack/chudburger/menu
	icon = 'icons/obj/economy.dmi'
	icon_state = "menu"
	goods = list(
		new /datum/data/shopping_good("Chudburger",			/obj/item/reagent_containers/food/snacks/burger/chud,			50)
		)