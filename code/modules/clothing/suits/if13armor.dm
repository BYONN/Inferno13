/obj/item/clothing/suit/armor/if13/kevlar
	name = "kevlar vest"
	desc = "An outdated kevlar vest in woodland camo pattern. Might stop shrapnel, or at least, keep it from turning your insides to mush."
	icon_state = "kevlar"
	item_state = "kevlar"
	armor = list("beat" = 9, "slash" = 10, "stab" = 5, "shot" = 16, "enflame" = 5, "electric" = 8, "acid" = 2, "irradiation" = 2, "cold" = 8)
	obj_value = 600

/obj/item/clothing/suit/armor/if13/turnout
	name = "turnout jacket"
	desc = "An insulated firefighter jacket, for when you need to turn up the heat."
	icon_state = "turnout"
	item_state = "turnout"
	armor = list("beat" = 14, "slash" = 10, "stab" = 10, "shot" = 5, "enflame" = 20, "electric" = 16, "acid" = 12, "irradiation" = 5, "cold" = 14)
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	flags_inv = HIDEJUMPSUIT
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	heat_protection = CHEST|GROIN|LEGS|ARMS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	strip_delay = 60
	equip_delay_other = 60
	resistance_flags = FIRE_PROOF
	obj_value = 600

/obj/item/clothing/suit/armor/if13/leather
	name = "leather armor"
	desc = "Buhh."
	icon_state = "leather"
	item_state = "leather"
	armor = list("beat" = 16, "slash" = 12, "stab" = 12, "shot" = 12, "enflame" = 5, "electric" = 8, "acid" = 4, "irradiation" = 3, "cold" = 6)
	obj_value = 600