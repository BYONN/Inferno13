#define ARMORID "armor-[tier]-[beat]-[slash]-[stab]-[shot]-[enflame]-[electric]-[acid]-[irradiation]-[cold]-[melee]-[bullet]-[laser]-[energy]-[bomb]-[bio]-[rad]-[fire]-[acid]-[magic]-[wound]"

/proc/getArmor(tier = 0, linemelee = 0, linebullet = 0, linelaser = 0, beat = 0, slash = 0, stab = 0, shot = 0, enflame = 0, electric = 0, acid = 0, irradiation = 0, cold = 0, melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0, magic = 0, wound = 0)
	. = locate(ARMORID)
	if (!.)
		. = new /datum/armor(tier, linemelee, linebullet, linelaser, beat, slash, stab, shot, enflame, electric, acid, irradiation, cold, melee, bullet, laser, energy, bomb, bio, rad, fire, acid, magic, wound)

/datum/armor
	datum_flags = DF_USE_TAG
	var/tier  //1 to 11. Tier 1 - thin clothing, 2 - thick clothing , 3 - armored jackets, 4 - low quality/light armor, 5 - medium qual armor, 6 - medium high, 7 - high, 8 - exceptional/low qual PA, 9 - t45, 10 - t51, 11 - t60
	var/linemelee
	var/linebullet
	var/linelaser

	var/beat
	var/slash
	var/stab
	var/shot
	var/enflame
	var/electric
	var/acid
	var/irradiation
	var/cold

	var/melee
	var/bullet
	var/laser
	var/energy
	var/bomb
	var/bio
	var/rad
	var/fire
	var/magic
	var/wound
	//var/tierline = list(10, 20, 45, 60, 75, 90, 105, 125, 210, 235, 260) //old
	var/tierline = list(25, 50, 75, 100, 125, 150, 200, 250, 300, 350, 400, 500, 600) //new

/datum/armor/New(tier = 0, linemelee = 0, linebullet = 0, linelaser = 0, beat = 0, slash = 0, stab = 0, shot = 0, enflame = 0, electric = 0, acid = 0, irradiation = 0, cold = 0, melee = 0, bullet = 0, laser = 0,  energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0, magic = 0, wound = 0)

	if(tier) //ASSIGNS ARMOR VALUES BASED ON TIER, IT WILL USE ARMOR VALUES INSTEAD OF THE TIER FOR THAT VALUE IF THE ARMOR VALUE IS PRESENT
		linemelee = linemelee+tierline[tier] //If an armor has a tier value, having a linemelee value will add onto that tier value rather than replace it.
		linebullet = linebullet+tierline[tier]
		linelaser = linelaser+tierline[tier]
		wound = wound+(tier*5)

	src.linemelee = linemelee
	src.linebullet = linebullet
	src.linelaser = linelaser

	src.beat = beat
	src.slash = slash
	src.stab = stab
	src.shot = shot
	src.enflame = enflame
	src.electric = electric
	src.acid = acid
	src.irradiation = irradiation
	src.cold = cold

	src.energy = energy
	src.bomb = bomb
	src.bio = bio
	src.rad = rad
	src.fire = fire
	src.acid = acid
	src.magic = magic
	src.wound = wound
//DESERT ROSE 2 LINEARMOR EXPLAINED: Heavily influenced by this Skyrim mod https://www.nexusmods.com/skyrim/mods/15860 % damage reduction is exponential (E.G. 90 doubles the effective health increase of 80).
//Linearmor is linear (so 100 armor is twice 50). Linearmor will never equal 100 armor. If a mob were to have 100 health, each point of linearmor would be the equivalent to +1 effective health. For example, 100 linearmor = 200 effective health or 50% damage reduction.
	src.melee = 100*linemelee/(abs(linemelee)+100) || melee
	src.bullet = 100*linebullet/(abs(linebullet)+100) || bullet
	src.laser = 100*linelaser/(abs(linelaser)+100) || laser

	src.tier = 0
	tag = ARMORID

/datum/armor/proc/modifyRating(tier = 0, linemelee = 0, linebullet = 0, linelaser = 0, beat = 0, slash = 0, stab = 0, shot = 0, enflame = 0, electric = 0, acid = 0, irradiation = 0, cold = 0, melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0, magic = 0, wound = 0)
	return getArmor(tier, src.linemelee+linemelee, src.linebullet+linebullet, src.linelaser+linelaser, src.beat+beat, src.slash+slash, src.stab+stab, src.shot+shot, src.enflame+enflame, src.electric+electric, src.acid+acid, src.irradiation+irradiation, src.cold+cold, src.melee+melee, src.bullet+bullet, src.laser+laser, src.energy+energy, src.bomb+bomb, src.bio+bio, src.rad+rad, src.fire+fire, src.acid+acid, src.magic+magic, src.wound+wound)

/datum/armor/proc/modifyAllRatings(modifier = 0)
	return getArmor(tier, linemelee+modifier, linebullet+modifier, linelaser+modifier, beat+modifier, slash+modifier, stab+modifier, shot+modifier, enflame+modifier, electric+modifier, acid+modifier, irradiation+modifier, cold+modifier, melee, bullet, laser, energy+modifier, bomb+modifier, bio+modifier, rad+modifier, fire+modifier, acid+modifier, magic+modifier, wound+modifier)

/datum/armor/proc/setRating(tier, linemelee, linebullet, linelaser, beat, slash, stab, shot, enflame, electric, acid, irradiation, cold, melee, bullet, laser, energy, bomb, bio, rad, fire, acid, magic, wound)
	return getArmor((isnull(tier) ? src.tier : tier),\
					(isnull(linemelee) ? src.linemelee : linemelee),\
					(isnull(linebullet) ? src.linebullet : linebullet),\
					(isnull(linelaser) ? src.linelaser : linelaser),\
					(isnull(beat) ? src.beat : beat),\
					(isnull(slash) ? src.slash : slash),\
					(isnull(stab) ? src.stab : stab),\
					(isnull(shot) ? src.shot : shot),\
					(isnull(enflame) ? src.enflame : enflame),\
					(isnull(electric) ? src.electric : electric),\
					(isnull(acid) ? src.acid : acid),\
					(isnull(irradiation) ? src.irradiation : irradiation),\
					(isnull(cold) ? src.cold : cold),\
					(isnull(melee) ? src.melee : melee),\
					(isnull(bullet) ? src.bullet : bullet),\
					(isnull(laser) ? src.laser : laser),\
					(isnull(energy) ? src.energy : energy),\
					(isnull(bomb) ? src.bomb : bomb),\
					(isnull(bio) ? src.bio : bio),\
					(isnull(rad) ? src.rad : rad),\
					(isnull(fire) ? src.fire : fire),\
					(isnull(acid) ? src.acid : acid),\
					(isnull(magic) ? src.magic : magic),\
					(isnull(wound) ? src.wound : wound))

/datum/armor/proc/getRating(rating)
	return vars[rating]

/datum/armor/proc/getList()
	return list("tier" = tier, "linemelee" = linemelee, "linebullet" = linebullet, "linelaser" = linelaser, "beat" = beat, "slash" = slash, "stab" = stab, "shot" = shot, "enflame" = enflame, "electric" = electric, "acid" = acid, "irradiation" = irradiation, "cold" = cold, "melee" = melee, "bullet" = bullet, "laser" = laser, "energy" = energy, "bomb" = bomb, "bio" = bio, "rad" = rad, "fire" = fire, "acid" = acid, "magic" = magic, "wound" = wound)

/datum/armor/proc/attachArmor(datum/armor/AA)
	return getArmor(tier, linemelee+AA.linemelee, linebullet+AA.linebullet, linelaser+AA.linelaser, beat+AA.beat, slash+AA.slash, stab+AA.stab, shot+AA.shot, enflame+AA.enflame, electric+AA.electric, acid+AA.acid, irradiation+AA.irradiation, cold+AA.cold, melee+AA.melee, bullet+AA.bullet, laser+AA.laser, energy+AA.energy, bomb+AA.bomb, bio+AA.bio, rad+AA.rad, fire+AA.fire, acid+AA.acid, magic+AA.magic, wound+AA.wound)

/datum/armor/proc/detachArmor(datum/armor/AA)
	return getArmor(tier, linemelee-AA.linemelee, linebullet-AA.linebullet, linelaser-AA.linelaser, beat-AA.beat, slash-AA.slash, stab-AA.stab, shot-AA.shot, enflame-AA.enflame, electric-AA.electric, acid-AA.acid, irradiation-AA.irradiation, cold-AA.cold, melee+AA.melee, bullet+AA.bullet, laser+AA.laser, energy-AA.energy, bomb-AA.bomb, bio-AA.bio, rad-AA.rad, fire-AA.fire, acid-AA.acid, magic-AA.magic, wound-AA.wound)

/datum/armor/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, tag))
		return FALSE
	. = ..()
	tag = ARMORID // update tag in case armor values were edited

#undef ARMORID
