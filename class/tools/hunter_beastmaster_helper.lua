local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts

do
	local name = "Xelhelp"
	local desc = "[Xel][8.x] Spellhelper: Beastmaster"
	local code = [[
AddIcon
{
	# Remove a line when you have its colour
	# Spells
	Texture(ability_hunter_cobrashot) # Cobra Shot
	Texture(ability_hunter_barbedshot) # Barbed Shot
	Texture(ability_hunter_killcommand) # Kill Command
	Texture(ability_upgrademoonglaive) # Multi-Shot
	Texture(inv_ammo_arrow_03) # Counter Shot (silence)
	Texture(ability_devour) # Intimidation (stun)

	# Buffs
	Texture(spell_nature_protectionformnature) # Aspect of the Wild
	Texture(ability_druid_ferociousbite) # Bestial Wrath
	Texture(ability_hunter_onewithnature) # Exhilaration
	Texture(ability_hunter_mendpet) # Mend Pet
	Texture(inv_misc_pheonixpet_01) # Heart of the Phoenix
	Texture(ability_hunter_beastsoothe) # Revive Pet
	Texture(icon_orangebird_toy) # Call Pet

	# Talents
	Texture(ability_hunter_longevity) # Dire Beast (T1)
	Texture(ability_hunter_chimerashot2) # Chimaera Shot (T2)
	Texture(ability_hunter_camouflage) # Camouflage (T3)
	Texture(ability_hunter_murderofcrows) # A Murder of Crows (T4)
	Texture(spell_shaman_bindelemental) # Binding Shot (T5)
	Texture(ability_hunter_rapidregeneration) # Barrage (T6)
	Texture(ability_hunter_bestialdiscipline) # Stampede (T6)
	Texture(ability_hunter_cobrastrikes) # Spitting Cobra (T7)

	# Racials
	Texture(racial_orc_berserkerstrength) # Blood Fury (Orc)
	Texture(racial_troll_berserk) # Berserking (Troll)
	Texture(spell_shadow_teleport) # Arcane Torrent (Blood Elf)
	Texture(ability_warstomp) # War Stomp (Tauren)
	Texture(spell_shadow_raisedead) # Will of the Forsaken (Undead)
	Texture(inv_gizmo_rocketlauncher) # Rocket Barrage (Goblin)
	Texture(pandarenracial_quiveringpain) # Quaking Palm (Pandaren)
	Texture(spell_shadow_unholystrength) # Stoneform (Dwarf)
	Texture(spell_shadow_charm) # Every Man for Himself (Human)
	Texture(spell_holy_holyprotection) # Gift of the Naaru (Draenei)
	Texture(ability_racial_darkflight) # Darkflight (Worgen)
	Texture(ability_ambush) # Shadowmeld (Night elf)
}





























]]

	OvaleScripts:RegisterScript("HUNTER", "beast_mastery", name, desc, code, "script")
end
