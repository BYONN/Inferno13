/obj/item/storage/box/shopping_bag
	name = "shopping bag"
	desc = "A disposable shopping bag."
	icon_state = "bag"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	foldable = null
	illustration = null
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/shopping_bag/update_icon()
	..()
	if (contents.len)
		icon_state = "bag-full"
	else
		icon_state = "bag"

/obj/item/storage/box/shopping_bag/Exited()
	. = ..()
	if (!contents.len)
		qdel(src)
	update_icon()

/obj/item/storage/box/shopping_bag/Entered()
	. = ..()
	update_icon()