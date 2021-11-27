/obj/machinery/shop_counter/meds4less
	store = "Meds4Less"
	bag_icon = "meds4less"

/obj/machinery/shop_rack/meds4less
	store = "Meds4Less"

/obj/machinery/shop_rack/meds4less/meds
	icon_state = "meds"
	goods = list(
		new /datum/data/shopping_good("Nanite Healer",			/obj/item/reagent_containers/hypospray/medipen/nanite,	100),
		new /datum/data/shopping_good("First Aid Kit",			/obj/item/storage/firstaid,								300),
		new /datum/data/shopping_good("Gauze",					/obj/item/stack/medical/gauze,							30),
		new /datum/data/shopping_good("Suture",					/obj/item/stack/medical/suture,							50),
		new /datum/data/shopping_good("Ointment",				/obj/item/stack/medical/ointment,						50),
		new /datum/data/shopping_good("Health Analyzer",		/obj/item/healthanalyzer,								100)
		)