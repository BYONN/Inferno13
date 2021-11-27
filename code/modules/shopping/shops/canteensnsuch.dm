/obj/machinery/shop_counter/canteensnsuch
	store = "Canteens 'N Such"
	bag_icon = "canteensnsuch"
	bought_objects = list(
		/obj/item/stack/ore,
		/obj/item/stack/sheet)

/obj/machinery/shop_rack/canteensnsuch
	store = "Canteens 'N Such"

/obj/machinery/shop_rack/canteensnsuch/canteens
	icon_state = "canteens"
	goods = list(
		new /datum/data/shopping_good("Green Canteen",			/obj/item/reagent_containers/food/drinks/flask/canteen,			100),
		new /datum/data/shopping_good("Gray Canteen",			/obj/item/reagent_containers/food/drinks/flask/canteen/gray,	100),
		new /datum/data/shopping_good("Piss Canteen",			/obj/item/reagent_containers/food/drinks/flask/canteen/piss,	200)
		)

/obj/machinery/shop_rack/canteensnsuch/tools
	icon_state = "tools"
	goods = list(
		new /datum/data/shopping_good("Pickaxe",			/obj/item/pickaxe,						150),
		new /datum/data/shopping_good("Compact Pickaxe",	/obj/item/pickaxe/mini,					100),
		new /datum/data/shopping_good("Shovel",				/obj/item/shovel,						100),
		new /datum/data/shopping_good("Spade",				/obj/item/shovel/spade,					60),
		new /datum/data/shopping_good("Mining Scanner",		/obj/item/mining_scanner,				210),
		new /datum/data/shopping_good("Mining Bag",			/obj/item/storage/bag/ore,				50)
		)

/obj/machinery/shop_rack/canteensnsuch/survival
	icon_state = "survival"
	goods = list(
		new /datum/data/shopping_good("Gas Mask",				/obj/item/clothing/mask/gas,					200),
		new /datum/data/shopping_good("Satchel",				/obj/item/storage/backpack/satchel/explorer,	250),
		new /datum/data/shopping_good("Flashlight",				/obj/item/flashlight,							150),
		new /datum/data/shopping_good("Heavy-duty Flashlight",	/obj/item/flashlight/seclite,					250),
		new /datum/data/shopping_good("Lantern",				/obj/item/flashlight/lantern,					300)
		)