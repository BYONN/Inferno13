/obj/machinery/shop_counter/ammunation
	store = "Ammunation"
	bag_icon = "ammunation"
	bought_objects = list(
		/obj/item/melee,
		/obj/item/gun
		)

/obj/machinery/shop_rack/ammunation
	store = "Ammunation"

/obj/machinery/shop_rack/ammunation/pistols
	icon_state = "pistols"
	goods = list(
		new /datum/data/shopping_good("Ruger MKII",					/obj/item/gun/ballistic/automatic/pistol/pistol22,				150),
		new /datum/data/shopping_good("Browning Hi-power",			/obj/item/gun/ballistic/automatic/pistol/ninemil,				200),
		new /datum/data/shopping_good("M1911",						/obj/item/gun/ballistic/automatic/pistol/m1911,					300)
		)

/obj/machinery/shop_rack/ammunation/magazines
	icon_state = "magazines"
	goods = list(
		new /datum/data/shopping_good(".38 Speedloader",			/obj/item/ammo_box/c38,							20),
		new /datum/data/shopping_good(".22 Magazine",				/obj/item/ammo_box/magazine/m22,				30),
		new /datum/data/shopping_good("9mm Magazine",				/obj/item/ammo_box/magazine/m9mm,				70),
		new /datum/data/shopping_good(".45 ACP Magazine",			/obj/item/ammo_box/magazine/m45,				80)
		)

/obj/machinery/shop_rack/ammunation/clubs
	icon_state = "clubs"
	goods = list(
		new /datum/data/shopping_good("Shovel",						/obj/item/shovel,								100),
		new /datum/data/shopping_good("9 iron",						/obj/item/twohanded/baseball/golfclub,				150),
		new /datum/data/shopping_good("Baseball Bat",				/obj/item/twohanded/baseball,					200)
		)

/obj/machinery/shop_rack/ammunation/blades
	icon_state = "blades"
	goods = list(
		new /datum/data/shopping_good("Kitchen Knife",				/obj/item/kitchen/knife,						150),
		new /datum/data/shopping_good("Bone Dagger",				/obj/item/kitchen/knife/combat/bone,			200),
		new /datum/data/shopping_good("Machete",					/obj/item/melee/onehanded/machete,						300)
		)