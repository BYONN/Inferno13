/obj/item/clothing/head/helmet/if13/kevlar
	name = "kevlar helmet"
	desc = "A pre-Calamity standard issue camo helmet. Some light scratches dot the surface, but it'll keep your noggin safe. Hopefully."
	icon_state = "kevlar"
	item_state = "kevlar"
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	armor = list("beat" = 9, "slash" = 10, "stab" = 5, "shot" = 16, "enflame" = 5, "electric" = 8, "acid" = 2, "irradiation" = 2, "cold" = 8)
	obj_value = 400

/obj/item/clothing/head/helmet/if13/turnout
	name = "turnout helmet"
	desc = "A firefighter helmet. The light's busted, but your noggin hopefully won't be."
	icon_state = "turnout"
	item_state = "turnout"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("beat" = 14, "slash" = 10, "stab" = 10, "shot" = 5, "enflame" = 20, "electric" = 16, "acid" = 12, "irradiation" = 5, "cold" = 14)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	obj_value = 400

/obj/item/clothing/head/helmet/if13/leather
	name = "leather cap"
	desc = "Buhh."
	icon_state = "leather"
	item_state = "leather"
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	armor = list("beat" = 16, "slash" = 12, "stab" = 12, "shot" = 12, "enflame" = 5, "electric" = 8, "acid" = 4, "irradiation" = 3, "cold" = 12)
	obj_value = 400