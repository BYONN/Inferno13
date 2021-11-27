/obj/item/clothing/gloves/if13
	body_parts_covered = ARMS|HANDS

/obj/item/clothing/gloves/if13/kevlar
	name = "kevlar gloves"
	desc = "These gloves have kevlar padding on the back, minimizing loss of flexibility."
	icon_state = "kevlar"
	item_state = "kevlar"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	armor = list("beat" = 12, "slash" = 12, "stab" = 12, "shot" = 16, "enflame" = 5, "electric" = 8, "acid" = 2, "irradiation" = 2, "cold" = 8)
	obj_value = 200

/obj/item/clothing/gloves/if13/turnout
	name = "turnout gloves"
	desc = "Fire resistant firefighter gloves. These aren't your everyday oven mitts."
	icon_state = "turnout"
	item_state = "turnout"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	armor = list("beat" = 13, "slash" = 13, "stab" = 13, "shot" = 13, "enflame" = 20, "electric" = 16, "acid" = 12, "irradiation" = 5, "cold" = 14)
	strip_mod = 0.9
	obj_value = 200

/obj/item/clothing/gloves/if13/leather
	name = "leather gloves"
	desc = "Buhh."
	icon_state = "leather"
	item_state = "leather"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	armor = list("beat" = 14, "slash" = 14, "stab" = 12, "shot" = 12, "enflame" = 5, "electric" = 8, "acid" = 4, "irradiation" = 3, "cold" = 12)
	obj_value = 200