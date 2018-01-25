local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts

do
	local name = "xeltor_prot"
	local desc = "[Xel][7.3] Paladin: Protection"
	local code = [[
Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_paladin_spells)

# Protection
AddIcon specialization=2 help=main
{
	# Interrupt
	if InCombat() InterruptActions()
	
	if { target.InRange(shield_of_the_righteous) or target.InRange(hammer_of_the_righteous) } and HasFullControl()
	{
		if not BuffPresent(consecration_buff) Spell(consecration)
		ProtectionDefaultCdActions()
		ProtectionDefaultShortCdActions()
		ProtectionDefaultMainActions()
	}
}

AddFunction InterruptActions
{
	if not target.IsFriend() and target.IsInterruptible() and { target.MustBeInterrupted() or Level() < 100 or target.IsPVP() }
	{
		if target.InRange(rebuke) Spell(rebuke)
		if not target.Classification(worldboss)
		{
			if target.InRange(avengers_shield) and Level() >= 42 Spell(avengers_shield)
			if not InFlightToTarget(avengers_shield) and not target.Classification(worldboss)
			{
				if target.InRange(hammer_of_justice) Spell(hammer_of_justice)
				if target.Distance(less 10) Spell(blinding_light)
				if target.Distance(less 8) Spell(arcane_torrent_holy)
				if target.InRange(quaking_palm) Spell(quaking_palm)
				if target.Distance(less 8) Spell(war_stomp)
			}
		}
	}
}

### actions.default

AddFunction ProtectionDefaultMainActions
{
 #arcane_torrent
 #call_action_list,name=prot
 ProtectionProtMainActions()
}

AddFunction ProtectionDefaultMainPostConditions
{
 ProtectionProtMainPostConditions()
}

AddFunction ProtectionDefaultShortCdActions
{
 #auto_attack
 # ProtectionGetInMeleeRange()
 #arcane_torrent
 #call_action_list,name=prot
 ProtectionProtShortCdActions()
}

AddFunction ProtectionDefaultShortCdPostConditions
{
 ProtectionProtShortCdPostConditions()
}

AddFunction ProtectionDefaultCdActions
{
 #use_item,name=apocalypse_drive
 # ProtectionUseItemActions()
 #blood_fury
 # Spell(blood_fury_apsp)
 #berserking
 # Spell(berserking)
 #arcane_torrent
 #blood_fury
 Spell(blood_fury_apsp)
 #berserking
 Spell(berserking)
 #arcane_torrent
 #call_action_list,name=prot
 ProtectionProtCdActions()
}

AddFunction ProtectionDefaultCdPostConditions
{
 ProtectionProtCdPostConditions()
}

### actions.max_dps

AddFunction ProtectionMaxDpsMainActions
{
}

AddFunction ProtectionMaxDpsMainPostConditions
{
}

AddFunction ProtectionMaxDpsShortCdActions
{
 #auto_attack
 # ProtectionGetInMeleeRange()
}

AddFunction ProtectionMaxDpsShortCdPostConditions
{
}

AddFunction ProtectionMaxDpsCdActions
{
 #use_item,name=apocalypse_drive
 # ProtectionUseItemActions()
 #blood_fury
 Spell(blood_fury_apsp)
 #berserking
 Spell(berserking)
}

AddFunction ProtectionMaxDpsCdPostConditions
{
}

### actions.max_survival

AddFunction ProtectionMaxSurvivalMainActions
{
}

AddFunction ProtectionMaxSurvivalMainPostConditions
{
}

AddFunction ProtectionMaxSurvivalShortCdActions
{
 #auto_attack
 # ProtectionGetInMeleeRange()
}

AddFunction ProtectionMaxSurvivalShortCdPostConditions
{
}

AddFunction ProtectionMaxSurvivalCdActions
{
 #use_item,name=apocalypse_drive
 # ProtectionUseItemActions()
 #blood_fury
 Spell(blood_fury_apsp)
 #berserking
 Spell(berserking)
}

AddFunction ProtectionMaxSurvivalCdPostConditions
{
}

### actions.precombat

AddFunction ProtectionPrecombatMainActions
{
}

AddFunction ProtectionPrecombatMainPostConditions
{
}

AddFunction ProtectionPrecombatShortCdActions
{
}

AddFunction ProtectionPrecombatShortCdPostConditions
{
}

AddFunction ProtectionPrecombatCdActions
{
 #flask,type=flask_of_ten_thousand_scars,if=!talent.seraphim.enabled
 #flask,type=flask_of_the_countless_armies,if=(role.attack|talent.seraphim.enabled)
 #food,type=seedbattered_fish_plate,if=!talent.seraphim.enabled
 #food,type=lavish_suramar_feast,if=(role.attack|talent.seraphim.enabled)
 #snapshot_stats
 #potion,name=unbending_potion,if=!talent.seraphim.enabled
 # if not Talent(seraphim_talent) and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(unbending_potion usable=1)
 #potion,name=old_war,if=(role.attack|talent.seraphim.enabled)&active_enemies<3
 # if { False(role_attack) or Talent(seraphim_talent) } and Enemies(tagged=1) < 3 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(old_war_potion usable=1)
 #potion,name=prolonged_power,if=(role.attack|talent.seraphim.enabled)&active_enemies>=3
 # if { False(role_attack) or Talent(seraphim_talent) } and Enemies(tagged=1) >= 3 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
}

AddFunction ProtectionPrecombatCdPostConditions
{
}

### actions.prot

AddFunction ProtectionProtMainActions
{
 #judgment,if=!talent.seraphim.enabled
 if not Talent(seraphim_talent) Spell(judgment)
 #avengers_shield,if=!talent.seraphim.enabled&talent.crusaders_judgment.enabled&buff.grand_crusader.up
 if not Talent(seraphim_talent) and BuffPresent(grand_crusader_buff) Spell(avengers_shield)
 #blessed_hammer,if=!talent.seraphim.enabled
 if not Talent(seraphim_talent) Spell(blessed_hammer)
 #avengers_shield,if=!talent.seraphim.enabled
 if not Talent(seraphim_talent) Spell(avengers_shield)
 #consecration,if=!talent.seraphim.enabled
 if not Talent(seraphim_talent) Spell(consecration)
 #hammer_of_the_righteous,if=!talent.seraphim.enabled
 if not Talent(seraphim_talent) Spell(hammer_of_the_righteous)
 #avengers_shield,if=talent.seraphim.enabled
 if Talent(seraphim_talent) Spell(avengers_shield)
 #judgment,if=talent.seraphim.enabled&(active_enemies<2|set_bonus.tier20_2pc)
 if Talent(seraphim_talent) and { Enemies(tagged=1) < 2 or ArmorSetBonus(T20 2) } Spell(judgment)
 #consecration,if=talent.seraphim.enabled&(buff.seraphim.remains>6|buff.seraphim.down)
 if Talent(seraphim_talent) and { BuffRemaining(seraphim_buff) > 6 or BuffExpires(seraphim_buff) } Spell(consecration)
 #judgment,if=talent.seraphim.enabled
 if Talent(seraphim_talent) Spell(judgment)
 #consecration,if=talent.seraphim.enabled
 if Talent(seraphim_talent) Spell(consecration)
 #blessed_hammer,if=talent.seraphim.enabled
 if Talent(seraphim_talent) Spell(blessed_hammer)
 #hammer_of_the_righteous,if=talent.seraphim.enabled
 if Talent(seraphim_talent) Spell(hammer_of_the_righteous)
}

AddFunction ProtectionProtMainPostConditions
{
}

AddFunction ProtectionProtShortCdActions
{
 #shield_of_the_righteous,if=!talent.seraphim.enabled&(action.shield_of_the_righteous.charges>2)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
 if not Talent(seraphim_talent) and Charges(shield_of_the_righteous) > 2 and not { target.DebuffPresent(eye_of_tyr_debuff) and BuffPresent(aegis_of_light_buff) and BuffPresent(ardent_defender_buff) and BuffPresent(guardian_of_ancient_kings_buff) and BuffPresent(divine_shield_buff) and BuffPresent(potion_buff) } Spell(shield_of_the_righteous)
 #light_of_the_protector,if=(health.pct<40)
 if HealthPercent() < 40 Spell(light_of_the_protector)
 #hand_of_the_protector,if=(health.pct<40)
 if HealthPercent() < 40 Spell(hand_of_the_protector)
 #light_of_the_protector,if=(incoming_damage_10000ms<health.max*1.25)&health.pct<55&talent.righteous_protector.enabled
 if IncomingDamage(10) < MaxHealth() * 1.25 and HealthPercent() < 55 and Talent(righteous_protector_talent) Spell(light_of_the_protector)
 #light_of_the_protector,if=(incoming_damage_13000ms<health.max*1.6)&health.pct<55
 if IncomingDamage(13) < MaxHealth() * 1.6 and HealthPercent() < 55 Spell(light_of_the_protector)
 #hand_of_the_protector,if=(incoming_damage_6000ms<health.max*0.7)&health.pct<65&talent.righteous_protector.enabled
 if IncomingDamage(6) < MaxHealth() * 0.7 and HealthPercent() < 65 and Talent(righteous_protector_talent) Spell(hand_of_the_protector)
 #hand_of_the_protector,if=(incoming_damage_9000ms<health.max*1.2)&health.pct<55
 if IncomingDamage(9) < MaxHealth() * 1.2 and HealthPercent() < 55 Spell(hand_of_the_protector)

 unless not Talent(seraphim_talent) and Spell(judgment) or not Talent(seraphim_talent) and Talent(crusaders_judgment_talent) and BuffPresent(grand_crusader_buff) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(blessed_hammer) or not Talent(seraphim_talent) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(consecration) or not Talent(seraphim_talent) and Spell(hammer_of_the_righteous)
 {
  #seraphim,if=talent.seraphim.enabled&action.shield_of_the_righteous.charges>=2
  if Talent(seraphim_talent) and Charges(shield_of_the_righteous) >= 2 Spell(seraphim)
  #shield_of_the_righteous,if=talent.seraphim.enabled&(cooldown.consecration.remains>=0.1&(action.shield_of_the_righteous.charges>2.5&cooldown.seraphim.remains>3)|(buff.seraphim.up))
  if Talent(seraphim_talent) and { SpellCooldown(consecration) >= 0.1 and Charges(shield_of_the_righteous) > 2.5 and SpellCooldown(seraphim) > 3 or BuffPresent(seraphim_buff) } Spell(shield_of_the_righteous)
 }
}

AddFunction ProtectionProtShortCdPostConditions
{
 not Talent(seraphim_talent) and Spell(judgment) or not Talent(seraphim_talent) and Talent(crusaders_judgment_talent) and BuffPresent(grand_crusader_buff) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(blessed_hammer) or not Talent(seraphim_talent) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(consecration) or not Talent(seraphim_talent) and Spell(hammer_of_the_righteous) or Talent(seraphim_talent) and Spell(avengers_shield) or Talent(seraphim_talent) and { Enemies(tagged=1) < 2 or ArmorSetBonus(T20 2) } and Spell(judgment) or Talent(seraphim_talent) and { BuffRemaining(seraphim_buff) > 6 or BuffExpires(seraphim_buff) } and Spell(consecration) or Talent(seraphim_talent) and Spell(judgment) or Talent(seraphim_talent) and Spell(consecration) or Talent(seraphim_talent) and Spell(blessed_hammer) or Talent(seraphim_talent) and Spell(hammer_of_the_righteous)
}

AddFunction ProtectionProtCdActions
{
 #bastion_of_light,if=!talent.seraphim.enabled&talent.bastion_of_light.enabled&action.shield_of_the_righteous.charges<1
 if not Talent(seraphim_talent) and Talent(bastion_of_light_talent) and Charges(shield_of_the_righteous) < 1 Spell(bastion_of_light)
 #divine_steed,if=!talent.seraphim.enabled&talent.knight_templar.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 # if not Talent(seraphim_talent) and Talent(knight_templar_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(divine_steed)
 #eye_of_tyr,if=!talent.seraphim.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 if not Talent(seraphim_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(eye_of_tyr)
 #aegis_of_light,if=!talent.seraphim.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 if not Talent(seraphim_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(aegis_of_light)
 #guardian_of_ancient_kings,if=!talent.seraphim.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 if not Talent(seraphim_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(guardian_of_ancient_kings)
 #divine_shield,if=!talent.seraphim.enabled&talent.final_stand.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 # if not Talent(seraphim_talent) and Talent(final_stand_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(divine_shield)
 #ardent_defender,if=!talent.seraphim.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 if not Talent(seraphim_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(ardent_defender)
 #lay_on_hands,if=!talent.seraphim.enabled&health.pct<15
 if not Talent(seraphim_talent) and HealthPercent() < 15 Spell(lay_on_hands)
 #potion,name=old_war,if=buff.avenging_wrath.up&talent.seraphim.enabled&active_enemies<3
 # if BuffPresent(avenging_wrath_melee_buff) and Talent(seraphim_talent) and Enemies(tagged=1) < 3 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(old_war_potion usable=1)
 #potion,name=prolonged_power,if=buff.avenging_wrath.up&talent.seraphim.enabled&active_enemies>=3
 # if BuffPresent(avenging_wrath_melee_buff) and Talent(seraphim_talent) and Enemies(tagged=1) >= 3 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
 #potion,name=unbending_potion,if=!talent.seraphim.enabled
 # if not Talent(seraphim_talent) and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(unbending_potion usable=1)
 #potion,name=draenic_strength,if=incoming_damage_2500ms>health.max*0.4&&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)|target.time_to_die<=25
 # if { IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } or target.TimeToDie() <= 25 } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(draenic_strength_potion usable=1)
 #stoneform,if=!talent.seraphim.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
 if not Talent(seraphim_talent) and IncomingDamage(2.5) > MaxHealth() * 0.4 and not { target.DebuffPresent(eye_of_tyr_debuff) or BuffPresent(aegis_of_light_buff) or BuffPresent(ardent_defender_buff) or BuffPresent(guardian_of_ancient_kings_buff) or BuffPresent(divine_shield_buff) or BuffPresent(potion_buff) } Spell(stoneform)
 #avenging_wrath,if=!talent.seraphim.enabled
 if not Talent(seraphim_talent) Spell(avenging_wrath_melee)

 unless not Talent(seraphim_talent) and Spell(judgment) or not Talent(seraphim_talent) and Talent(crusaders_judgment_talent) and BuffPresent(grand_crusader_buff) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(blessed_hammer) or not Talent(seraphim_talent) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(consecration) or not Talent(seraphim_talent) and Spell(hammer_of_the_righteous)
 {
  #avenging_wrath,if=talent.seraphim.enabled&(buff.seraphim.up|cooldown.seraphim.remains<4)
  if Talent(seraphim_talent) and { BuffPresent(seraphim_buff) or SpellCooldown(seraphim) < 4 } Spell(avenging_wrath_melee)
  #ardent_defender,if=talent.seraphim.enabled&buff.seraphim.up
  if Talent(seraphim_talent) and BuffPresent(seraphim_buff) Spell(ardent_defender)
  #eye_of_tyr,if=talent.seraphim.enabled&equipped.151812&buff.seraphim.up
  if Talent(seraphim_talent) and HasEquippedItem(151812) and BuffPresent(seraphim_buff) Spell(eye_of_tyr)

  unless Talent(seraphim_talent) and Spell(avengers_shield) or Talent(seraphim_talent) and { Enemies(tagged=1) < 2 or ArmorSetBonus(T20 2) } and Spell(judgment) or Talent(seraphim_talent) and { BuffRemaining(seraphim_buff) > 6 or BuffExpires(seraphim_buff) } and Spell(consecration) or Talent(seraphim_talent) and Spell(judgment) or Talent(seraphim_talent) and Spell(consecration)
  {
   #eye_of_tyr,if=talent.seraphim.enabled&!equipped.151812
   if Talent(seraphim_talent) and not HasEquippedItem(151812) Spell(eye_of_tyr)
  }
 }
}

AddFunction ProtectionProtCdPostConditions
{
 not Talent(seraphim_talent) and Spell(judgment) or not Talent(seraphim_talent) and Talent(crusaders_judgment_talent) and BuffPresent(grand_crusader_buff) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(blessed_hammer) or not Talent(seraphim_talent) and Spell(avengers_shield) or not Talent(seraphim_talent) and Spell(consecration) or not Talent(seraphim_talent) and Spell(hammer_of_the_righteous) or Talent(seraphim_talent) and Spell(avengers_shield) or Talent(seraphim_talent) and { Enemies(tagged=1) < 2 or ArmorSetBonus(T20 2) } and Spell(judgment) or Talent(seraphim_talent) and { BuffRemaining(seraphim_buff) > 6 or BuffExpires(seraphim_buff) } and Spell(consecration) or Talent(seraphim_talent) and Spell(judgment) or Talent(seraphim_talent) and Spell(consecration) or Talent(seraphim_talent) and Spell(blessed_hammer) or Talent(seraphim_talent) and Spell(hammer_of_the_righteous)
}
]]

	OvaleScripts:RegisterScript("PALADIN", "protection", name, desc, code, "script")
end
