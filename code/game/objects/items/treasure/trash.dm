/obj/item/treasure
	icon = 'icons/obj/treasure.dmi'

/obj/item/treasure/trash/tincan
	name = "tin can"
	desc = "An empty tin can. Nope, no use trying to drip it into your mouth."
	icon_state = "tincan1"
	obj_value = 10

/obj/item/treasure/trash/tincan/Initialize()
	..()
	icon_state = "tincan[rand(1,4)]"

/obj/item/treasure/trash/coffeepot
	name = "coffee pot"
	desc = "An old coffee pot. Probably not good for coffee anymore: who knows what's been living inside."
	icon_state = "coffee_pot"
	obj_value = 40

/obj/item/treasure/trash/pipe
	name = "pipe"
	desc = "An independent piece of pipe, out to strike its own fortune as a bludgeoning tool. It's not doing very well."
	icon_state = "pipe"
	obj_value = 20