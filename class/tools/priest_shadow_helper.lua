local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts

do
	local name = "Shadowhelp"
	local desc = "[Xel][7.x] Spellhelper: Shadow"
	local code = [[
AddIcon
{
	# Remove a line when you have its colour
	# Spells
	Texture(spell_shadow_shadowwordpain) # Shadow Word: Pain
	Texture(spell_holy_stoicism) # Vampiric Touch
	Texture(spell_shadow_unholyfrenzy) # Mind Blast
	Texture(spell_shadow_siphonmana) # Mind Flay
	Texture(spell_shadow_demonicfortitude) # Shadow Word: Death
	Texture(228260) # Void Eruption
	Texture(ability_ironmaidens_convulsiveshadows) # Void Bolt (Replaces Void Eruption)
	Texture(ability_priest_silence) # Silence

	# Buffs
	Texture(spell_shadow_dispersion) # Dispersion
	Texture(spell_shadow_shadowfiend) # Shadowfiend
	
	# Artifact
	Texture(inv_knife_1h_artifactcthun_d_01) # Void Torrent

	# Talents
	Texture(spell_mage_presenceofmind) # Shadow Word: Void (T1)
	Texture(spell_shadow_mindbomb) # Mind Bomb (T3)
	Texture(spell_holy_powerinfusion) # Power Infusion (T6)
	Texture(spell_shadow_soulleech_3) # Mindbender (T6) (Replaces Shadowfiend)
	Texture(spell_shadow_shadowfury) # Shadow Crash (T7)
	Texture(achievement_boss_generalvezax_01) # Surrender to Madness (T7)

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
	Texture(ability_rogue_trip) # Escape Artist (Gnome)
	Texture(ability_ambush) # Shadowmeld (Night Elf)
}




































]]

	OvaleScripts:RegisterScript("PRIEST", "shadow", name, desc, code, "script")
end
