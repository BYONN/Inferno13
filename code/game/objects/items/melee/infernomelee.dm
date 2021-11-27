#define CHARGE_INDICATOR_ANGLE_CHANGE_THRESHOLD 0.1

/obj/item
	var/combat_capable = FALSE //Whether it can swing as a weapon.
	var/attack_range = 2

/obj/item/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if (!combat_capable)
		return
	if (!istype(src, /obj/item/melee))
		if(!CheckAttackCooldown(user, target, TRUE))
			return
		if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
			melee_attack(target, user, flag, params)

/obj/item/proc/melee_attack(atom/target, mob/living/user, proximity_flag, clickparams)
	if(!user.CheckActionCooldown(CLICK_CD_MELEE))
		return
	var/turf/proj_turf = user.loc
	if (!isturf(proj_turf))
		return
	if (proximity_flag && !isturf(target))
		return
	user.DelayNextAction(CLICK_CD_MELEE)
	var/obj/item/projectile/melee/M = new /obj/item/projectile/melee(proj_turf)
	M.preparePixelProjectile(target, user, clickparams)
	M.firer = user
	M.name = name
	M.damage = apply_damage_modifier()
	M.damage_type = damtype
	M.flag = damtype
	M.hitsound = hitsound
	M.def_zone = ran_zone(user.zone_selected)
	M.range = attack_range
	if (user.mind.skill_holder)
		var/meleemod = 1 + user.mind.get_skill_level(/datum/skill/level/melee)/10
		M.damage *= meleemod
	playsound(user, 'sound/weapons/punchmiss.ogg', 100, 1)
	M.fire()
	after_melee_attack()
	return

/obj/item/proc/after_melee_attack()
	return

/obj/item/proc/apply_damage_modifier()
	return force

/obj/item/melee
	combat_capable = TRUE
	canMouseDown = TRUE
	var/charging = FALSE
	var/charge_time_left = 2 SECONDS
	var/charge_time = 2 SECONDS
	var/lastangle = 0
	var/indicator_lastangle = 0
	var/last_indicator = 0
	var/last_process = 0
	var/list/obj/effect/projectile/tracer/current_indicators
	var/mob/current_user = null

/obj/item/melee/apply_damage_modifier()
	if (charging)
		return (force/2) + ((charge_time-charge_time_left)/charge_time) * force
	else return force/2

/obj/item/melee/after_melee_attack()
	charging = FALSE

/obj/item/melee/Initialize()
	. = ..()
	current_indicators = list()

/obj/item/melee/pickup(mob/user)
	..()
	START_PROCESSING(SSfastprocess, src)

/obj/item/melee/dropped(mob/user)
	..()
	charging = FALSE
	STOP_PROCESSING(SSfastprocess, src)

/obj/item/melee/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	QDEL_LIST(current_indicators)
	..()

/obj/item/melee/process()
	if (!ishuman(loc))
		STOP_PROCESSING(SSfastprocess, src)
		return
	charge_time_left = max(0, charge_time_left - (world.time - last_process))
	last_process = world.time
	charge_indicator(TRUE)
	mouse_track()

/obj/item/melee/onMouseDown(object, location, params, mob/mob)
	if(!ishuman(mob))
		return ..()
	if(istype(object, /obj/screen) && !istype(object, /obj/screen/click_catcher))
		return
	if((object in mob.contents) || (object == mob))
		return
	if(SEND_SIGNAL(mob, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		set_user(mob)
		start_charging()
	return ..()

/obj/item/melee/onMouseUp(object, location, params, mob/M)
	if(istype(object, /obj/screen) && !istype(object, /obj/screen/click_catcher))
		return
	if(SEND_SIGNAL(M, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		melee_attack(object, M, M.can_reach(object,src), M.client.mouseParams)
		set_user(null)
	return ..()

obj/item/melee/onMouseDrag(src_object, over_object, src_location, over_location, params, mob)
	if(charging)
		mouse_track()
	return ..()

/obj/item/melee/proc/mouse_track()
	if (istype(current_user) && current_user.client && current_user.client.mouseParams)
		var/angle = mouse_angle_from_client(current_user.client)
		current_user.setDir(angle2dir_cardinal(angle))
		lastangle = angle

obj/item/melee/proc/charge_indicator(force_update = FALSE)
	var/diff = abs(indicator_lastangle - lastangle)
	if(!check_user())
		return
	if(((diff < CHARGE_INDICATOR_ANGLE_CHANGE_THRESHOLD) || ((last_indicator + 1) > world.time)) && !force_update)
		return
	indicator_lastangle = lastangle
	var/obj/item/projectile/beam/beam_rifle/hitscan/aiming_beam/P = new
	P.melee_weapon = src
	P.range = attack_range
	if(charge_time)
		var/percent = ((100/charge_time)*charge_time_left)
		P.color = rgb(255 * percent,255 * ((100 - percent) / 100),0)
	else
		P.color = rgb(0, 255, 0)
	var/turf/curloc = get_turf(src)
	var/turf/targloc = get_turf(current_user.client.mouseObject)
	if(!istype(targloc))
		if(!istype(curloc))
			return
		targloc = get_turf_in_angle(lastangle, curloc, 10)
	P.preparePixelProjectile(targloc, current_user, current_user.client.mouseParams, 0)
	P.fire(lastangle)
	last_indicator = world.time

/obj/item/melee/proc/check_user(automatic_cleanup = TRUE)
	if(!istype(current_user) || !isturf(current_user.loc) || !(src in current_user.held_items) || current_user.incapacitated())	//Doesn't work if you're not holding it!
		if(automatic_cleanup)
			set_user(null)
		return FALSE
	return TRUE

/obj/item/melee/proc/on_mob_move()
	check_user()
	if(charging)
		charge_indicator(TRUE)

/obj/item/melee/proc/start_charging()
	charge_time_left = charge_time
	charging = TRUE

/obj/item/melee/proc/stop_charging()
	set waitfor = FALSE
	charge_time_left = charge_time
	charging = FALSE
	QDEL_LIST(current_indicators)

/obj/item/melee/proc/set_user(mob/user)
	if(user == current_user)
		return
	stop_charging(current_user)
	if(current_user)
		UnregisterSignal(current_user, COMSIG_MOVABLE_MOVED)
		current_user = null
	if(istype(user))
		current_user = user
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/on_mob_move)

//pseudo-ranged melee attack
/obj/item/projectile/melee
	name = "swing"
	icon_state = "swing"
	damage = 0
	damage_type = BRUTE
	flag = "beat"
	range = 2
	pixels_per_second = TILES_TO_PIXELS(8)

/obj/item/projectile/melee/Initialize()
	. = ..()
	def_zone = ran_zone(BODY_ZONE_CHEST,45)

/obj/item/projectile/melee/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/human/F = firer
	if (F && F.mind.skill_holder && isliving(target) && target:stat != DEAD)
		if (blocked < 100)
			F.mind.auto_gain_experience(/datum/skill/level/melee, 5, 10000)