local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts

do
	local name = "DKUhelp"
	local desc = "[Xel][8.0] Spellhelper: Unholy"
	local code = [[
AddIcon
{
	# Remove a line when you have its colour
	# Spells
	Texture(spell_deathknight_festering_strike) # Festering Strike
	Texture(spell_deathknight_scourgestrike) # Scourge Strike
	Texture(spell_shadow_deathcoil) # Death Coil
	Texture(spell_deathvortex) # Outbreak
	Texture(artifactability_unholydeathknight_deathsembrace) # Apocalypse
	Texture(spell_shadow_deathanddecay) # Death and Decay
	Texture(spell_deathknight_butcher2) # Death Strike
	Texture(spell_deathknight_mindfreeze) # Mind Freeze

	# Buffs
	Texture(inv_pet_ghoul) # Raise Dead
	Texture(achievement_boss_festergutrotface) # Dark Transformation
	Texture(spell_deathknight_armyofthedead) # Army of the Dead

	# Talents
	Texture(warlock_curse_shadow) # Clawing Shadows (T1)
	Texture(spell_shadow_contagion) # Unholy Blight (T2)
	Texture(ability_deathknight_asphixiate) # Asphyxiate (T3)
	Texture(ability_deathknight_soulreaper) # Soul Reaper (T4)
	Texture(ability_deathknight_soulreaper) # Wraith Walk (T5)
	Texture(ability_deathknight_soulreaper) # Death Pact (T5)
	Texture(spell_deathknight_defile) # Defile (T6)
	Texture(spell_nature_nullifydisease) # Epidemic (T6)
	Texture(spell_shadow_unholyfrenzy) # Unholy Frenzy (T7)
	Texture(ability_deathknight_summongargoyle) # Summon Gargoyle (T7)

	# Racials
	Texture(racial_orc_berserkerstrength) # Blood Fury (Orc)
	Texture(racial_troll_berserk) # Berserking (Troll)
	Texture(spell_shadow_teleport) # Arcane Torrent (Blood Elf)
	Texture(ability_warstomp) # War Stomp (Tauren)
	Texture(spell_shadow_raisedead) # Will of the Forsaken (Undead)
	Texture(inv_gizmo_rocketlauncher) # Rocket Barrage (Goblin)
	Texture(spell_shadow_unholystrength) # Stoneform (Dwarf)
	Texture(spell_shadow_charm) # Every Man for Himself (Human)
	Texture(spell_holy_holyprotection) # Gift of the Naaru (Draenei)
	Texture(ability_racial_darkflight) # Darkflight (Worgen)
	Texture(ability_rogue_trip) # Escape Artist (Gnome)
	Texture(ability_ambush) # Shadowmeld (Night elf)
}































]]

	OvaleScripts:RegisterScript("DEATHKNIGHT", "unholy", name, desc, code, "script")
end
