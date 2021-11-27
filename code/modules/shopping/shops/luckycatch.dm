/obj/machinery/shop_counter/luckycatch
	store = "Lucky Catch"
	bag_icon = "luckycatch"
	bought_objects = list(
		/obj/item/fishy,
		/obj/item/fishyegg,
		/obj/item/fishingrod,
		/obj/item/reagent_containers/food/snacks/fishmeat)

/obj/machinery/shop_rack/luckycatch
	store = "Lucky Catch"

/obj/machinery/shop_rack/luckycatch/fishingrods
	icon_state = "fishingrods"
	goods = list(
		new /datum/data/shopping_good("Fishing Rod",			/obj/item/fishingrod,			200)
		)