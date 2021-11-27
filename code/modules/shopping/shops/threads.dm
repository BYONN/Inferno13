/obj/machinery/shop_counter/threads
	store = "Threads"
	bag_icon = "threads"
	bought_objects = list(
		/obj/item/clothing/suit,
		/obj/item/clothing/head,
		/obj/item/clothing/gloves,
		/obj/item/clothing/shoes)

/obj/machinery/shop_rack/threads
	store = "Threads"

/obj/machinery/shop_rack/threads/shoes
	icon_state = "shoes"
	goods = list(
		new /datum/data/shopping_good("Laceups",			/obj/item/clothing/shoes/laceup,					70),
		new /datum/data/shopping_good("Winter Boots",		/obj/item/clothing/shoes/winterboots,				80),
		new /datum/data/shopping_good("Sandals",			/obj/item/clothing/shoes/sandal,					20),
		new /datum/data/shopping_good("Brown Shoes",		/obj/item/clothing/shoes/sneakers/brown,			50),
		new /datum/data/shopping_good("Black Shoes",		/obj/item/clothing/shoes/sneakers/black,			50),
		new /datum/data/shopping_good("Red Shoes",			/obj/item/clothing/shoes/sneakers/red,				60)
		)

/obj/machinery/shop_rack/threads/hats
	icon_state = "hats"
	goods = list(
		new /datum/data/shopping_good("Flatcap",				/obj/item/clothing/head/flatcap,					70),
		new /datum/data/shopping_good("Pirate Hat",				/obj/item/clothing/head/pirate,						100),
		new /datum/data/shopping_good("Bowler Hat",				/obj/item/clothing/head/bowler,						80),
		new /datum/data/shopping_good("Tophat",					/obj/item/clothing/head/that,						100),
		new /datum/data/shopping_good("Green Striped Beanie",	/obj/item/clothing/head/beanie/stripedgreen,		60),
		new /datum/data/shopping_good("Red Beanie",				/obj/item/clothing/head/beanie/red,					60)
		)

/obj/machinery/shop_rack/threads/under
	icon_state = "under"
	goods = list(
		new /datum/data/shopping_good("Tactical Turtleneck",	/obj/item/clothing/under/syndicate/tacticool,		150),
		new /datum/data/shopping_good("Black Suit",				/obj/item/clothing/under/lawyer/blacksuit,			200),
		new /datum/data/shopping_good("Maid Uniform",			/obj/item/clothing/under/janimaid,					130),
		new /datum/data/shopping_good("Hazard Jumpsuit",		/obj/item/clothing/under/rank/engineering/engineer,	100),
		new /datum/data/shopping_good("Navy Jumpsuit",			/obj/item/clothing/under/f13/navy,					120)
		)