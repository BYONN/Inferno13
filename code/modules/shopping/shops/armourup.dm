/obj/machinery/shop_counter/armourup
	store = "Armour Up"
	bag_icon = "armourup"
	bought_objects = list(
		/obj/item/clothing/suit,
		/obj/item/clothing/head,
		/obj/item/clothing/gloves,
		/obj/item/clothing/shoes,
		/obj/item/stack/sheet/animalhide
		)

/obj/machinery/shop_rack/armourup
	store = "Armour Up"

/obj/machinery/shop_rack/armourup/kevlar
	icon_state = "kevlar"
	goods = list(
		new /datum/data/shopping_good("Kevlar Vest",			/obj/item/clothing/suit/armor/if13/kevlar,				600),
		new /datum/data/shopping_good("Kevlar Helmet",			/obj/item/clothing/head/helmet/if13/kevlar,				400),
		new /datum/data/shopping_good("Kevlar Gloves",			/obj/item/clothing/gloves/if13/kevlar,					200),
		new /datum/data/shopping_good("Kevlar Boots",			/obj/item/clothing/shoes/if13/kevlar,					200)
		)

/obj/machinery/shop_rack/armourup/turnout
	icon_state = "turnout"
	goods = list(
		new /datum/data/shopping_good("Turnout Jacket",			/obj/item/clothing/suit/armor/if13/turnout,				600),
		new /datum/data/shopping_good("Turnout Helmet",			/obj/item/clothing/head/helmet/if13/turnout,			400),
		new /datum/data/shopping_good("Turnout Gloves",			/obj/item/clothing/gloves/if13/turnout,					200),
		new /datum/data/shopping_good("Turnout Boots",			/obj/item/clothing/shoes/if13/turnout,					200)
		)

/obj/machinery/shop_rack/armourup/leather
	icon_state = "leather"
	goods = list(
		new /datum/data/shopping_good("Leather Armour",			/obj/item/clothing/suit/armor/if13/leather,				600),
		new /datum/data/shopping_good("Leather Cap",			/obj/item/clothing/head/helmet/if13/leather,			400),
		new /datum/data/shopping_good("Leather Gloves",			/obj/item/clothing/gloves/if13/leather,					200),
		new /datum/data/shopping_good("Leather Boots",			/obj/item/clothing/shoes/if13/leather,					200)
		)