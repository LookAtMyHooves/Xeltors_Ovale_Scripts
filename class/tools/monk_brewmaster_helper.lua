local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts

do
	local name = "MBMhelp"
	local desc = "[Xel][7.3] Spellhelper: Brewmaster"
	local code = [[
AddIcon
{
	# Remove a line when you have its colour
	# Spells
	Texture(achievement_brewery_2) # Keg Smash
	Texture(ability_monk_tigerpalm) # Tiger Palm
	Texture(ability_monk_blackoutstrike) # Blackout Strike
	Texture(ability_monk_breathoffire) # Breath of Fire
	Texture(ability_monk_expelharm) # Expel Harm
	Texture(ability_monk_spearhand) # Spear Hand Strike
	Texture(ability_monk_paralysis) # Paralysis

	# Buffs
	Texture(ability_monk_ironskinbrew) # Ironskin Brew
	Texture(inv_misc_beer_06) # Purifying Brew
	Texture(ability_monk_fortifyingale_new) # Fortifying Brew
	
	# Artifact
	Texture(inv_staff_2h_artifactmonkeyking_d_02) # Exploding Keg

	# Talents
	Texture(spell_arcane_arcanetorrent) # Chi Burst (T1)
	Texture(ability_monk_chiwave) # Chi Wave (T1)
	Texture(ability_monk_quitornado) # Chi Torpedo (T2)
	Texture(ability_monk_tigerslust) # Tiger's Lust (T2)
	Texture(ability_monk_chibrew) # Black Ox Brew (T3)
	Texture(spell_monk_ringofpeace) # Ring of Peace (T4)
	Texture(monk_ability_summonoxstatue) # Summon Black Ox Statue (T4)
	Texture(ability_monk_legsweep) # Leg Sweep (T4)
	Texture(ability_monk_jasmineforcetea) # Healing Elixir (T5)
	Texture(ability_monk_dampenharm) # Dampen Harm (T5)
	Texture(ability_monk_rushingjadewind) # Rushing Jade Wind (T6)
	Texture(ability_monk_summontigerstatue) # Invoke Niuzao, the Black Ox (T6)

	# Racials
	Texture(racial_orc_berserkerstrength) # Blood Fury (Orc)
	Texture(racial_troll_berserk) # Berserking (Troll)
	Texture(spell_shadow_teleport) # Arcane Torrent (Blood Elf)
	Texture(ability_warstomp) # War Stomp (Tauren)
	Texture(spell_shadow_raisedead) # Will of the Forsaken (Undead)
	Texture(pandarenracial_quiveringpain) # Quaking Palm (Pandaren)
	Texture(spell_shadow_unholystrength) # Stoneform (Dwarf)
	Texture(spell_shadow_charm) # Every Man for Himself (Human)
	Texture(spell_holy_holyprotection) # Gift of the Naaru (Draenei)
	Texture(ability_rogue_trip) # Escape Artist (Gnome)
	Texture(ability_ambush) # Shadowmeld (Night Elf)
}
]]

	OvaleScripts:RegisterScript("MONK", "brewmaster", name, desc, code, "script")
end
