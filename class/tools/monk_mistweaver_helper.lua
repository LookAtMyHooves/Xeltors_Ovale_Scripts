local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts

do
	local name = "MMWhelp"
	local desc = "[Xel][7.0] Spellhelper: Mistweaver"
	local code = [[
AddIcon
{
	# Remove a line when you have its colour
	# Spells
	Texture(ability_monk_effuse) # Effuse
	Texture(spell_monk_envelopingmist) # Enveloping Mist
	Texture(ability_monk_renewingmists) # Renewing Mist
	Texture(ability_monk_vivify) # Vivify
	Texture(ability_monk_essencefont) # Essence Font
	Texture(ability_monk_tigerpalm) # Tiger Palm
	Texture(ability_monk_roundhousekick) # Blackout Kick
	Texture(ability_monk_risingsunkick) # Rising Sun Kick
	Texture(ability_monk_paralysis) # Paralysis
	
	# Buffs
	Texture(ability_monk_chicocoon) # Life Cocoon
	Texture(ability_monk_thunderfocustea) # Thunder Focus Tea
	
	# Artifact
	Texture(inv_staff_2h_artifactshaohao_d_01) # Sheilun's Gift

	# Talents
	Texture(spell_arcane_arcanetorrent) # Chi Burst (T1)
	Texture(ability_monk_forcesphere) # Zen Pulse (T1)
	Texture(ability_monk_chiwave) # Chi Wave (T1)
	Texture(ability_monk_quitornado) # Chi Torpedo (T2)
	Texture(ability_monk_tigerslust) # Tiger's Lust (T2)
	Texture(spell_monk_ringofpeace) # Ring of Peace (T4)
	Texture(ability_monk_legsweep) # Leg Sweep (T4)
	Texture(ability_monk_jasmineforcetea) # Healing Elixir (T5)
	Texture(spell_monk_diffusemagic) # Diffuse Magic (T5)
	Texture(ability_monk_dampenharm) # Dampen Harm (T5)
	Texture(ability_monk_rushingjadewind) # Refreshing Jade Wind (T6)
	Texture(ability_monk_summontigerstatue) # Invoke Chi-Ji, the Red Crane (T6)
	Texture(ability_monk_summonserpentstatue) # Summon Jade Serpent Statue (T6)
	Texture(monk_ability_cherrymanatea) # Mana Tea (T7)

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

	OvaleScripts:RegisterScript("MONK", "mistweaver", name, desc, code, "script")
end
