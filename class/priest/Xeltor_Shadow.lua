local _, XelOvaleScripts = ...
local Ovale = XelOvaleScripts.Ovale
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "xeltor_shadow"
	local desc = "[Xel][7.0.3] Priest: Shadow"
	local code = [[
# Based on SimulationCraft profile "Priest_Shadow_T18M".
#	class=priest
#	spec=shadow
#	talents=1133231

Include(ovale_common)
Include(ovale_interrupt)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_priest_spells)

AddIcon specialization=3 help=main
{
	if InCombat() and target.Casting(interrupt) InterruptActions()
	
	if InCombat() and HasFullControl() and target.InRange(mind_blast)
	{
		if Speed() == 0
		{
			ShadowDefaultCdActions()
			ShadowDefaultShortCdActions()
			ShadowDefaultMainActions()
		}
		
		if Speed() > 0
		{
			#shadow_word_pain,moving=1,cycle_targets=1
			if Speed() > 0 and target.DebuffExpires(shadow_word_pain) Spell(shadow_word_pain)
		}
	}
}

AddFunction Boss
{
	IsBossFight() or BuffPresent(burst_haste_buff any=1) or { target.IsPvP() and not target.IsFriend() } 
}

AddFunction InterruptActions
{
	if not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(silence) Spell(silence)
		if not target.Classification(worldboss)
		{
			if target.Distance(less 8) Spell(arcane_torrent_mana)
			if target.InRange(quaking_palm) Spell(quaking_palm)
			if target.Distance(less 8) Spell(war_stomp)
		}
	}
}

### actions.default

AddFunction ShadowDefaultMainActions
{
	#call_action_list,name=s2m,if=buff.voidform.up&buff.surrender_to_madness.up
	if BuffPresent(voidform_buff) and BuffPresent(surrender_to_madness_buff) ShadowS2mMainActions()
	#call_action_list,name=vf,if=buff.voidform.up
	if BuffPresent(voidform_buff) ShadowVfMainActions()
	#call_action_list,name=main
	ShadowMainMainActions()
}

AddFunction ShadowDefaultShortCdActions
{
	#call_action_list,name=s2m,if=buff.voidform.up&buff.surrender_to_madness.up
	if BuffPresent(voidform_buff) and BuffPresent(surrender_to_madness_buff) ShadowS2mShortCdActions()

	unless BuffPresent(voidform_buff) and BuffPresent(surrender_to_madness_buff) and ShadowS2mShortCdPostConditions()
	{
		#call_action_list,name=vf,if=buff.voidform.up
		if BuffPresent(voidform_buff) ShadowVfShortCdActions()

		unless BuffPresent(voidform_buff) and ShadowVfShortCdPostConditions()
		{
			#call_action_list,name=main
			ShadowMainShortCdActions()
		}
	}
}

AddFunction ShadowDefaultCdActions
{
	#use_item,slot=finger1
	# if CheckBoxOn(opt_legendary_ring_intellect) Item(legendary_ring_intellect usable=1)
	#call_action_list,name=s2m,if=buff.voidform.up&buff.surrender_to_madness.up
	if BuffPresent(voidform_buff) and BuffPresent(surrender_to_madness_buff) ShadowS2mCdActions()

	unless BuffPresent(voidform_buff) and BuffPresent(surrender_to_madness_buff) and ShadowS2mCdPostConditions()
	{
		#call_action_list,name=vf,if=buff.voidform.up
		if BuffPresent(voidform_buff) ShadowVfCdActions()

		unless BuffPresent(voidform_buff) and ShadowVfCdPostConditions()
		{
			#call_action_list,name=main
			ShadowMainCdActions()
		}
	}
}

### actions.main

AddFunction ShadowMainMainActions
{
	#shadow_word_pain,if=dot.shadow_word_pain.remains<(3+(4%3))*gcd
	if target.DebuffRemaining(shadow_word_pain_debuff) < { 3 + 4 / 3 } * GCD() Spell(shadow_word_pain)
	#vampiric_touch,if=dot.vampiric_touch.remains<(4+(4%3))*gcd
	if target.DebuffRemaining(vampiric_touch_debuff) < { 4 + 4 / 3 } * GCD() Spell(vampiric_touch)
	#shadow_word_pain,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
	if not target.DebuffPresent(shadow_word_pain_debuff) and Talent(legacy_of_the_void_talent) and Insanity() >= 70 Spell(shadow_word_pain)
	#vampiric_touch,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
	if not target.DebuffPresent(vampiric_touch_debuff) and Talent(legacy_of_the_void_talent) and Insanity() >= 70 Spell(vampiric_touch)
	#shadow_word_death,if=!talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=90
	if not Talent(reaper_of_souls_talent) and SpellChargeCooldown(shadow_word_death) == 2 and Insanity() <= 90 Spell(shadow_word_death)
	#shadow_word_death,if=talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=70
	if Talent(reaper_of_souls_talent) and SpellChargeCooldown(shadow_word_death) == 2 and Insanity() <= 70 Spell(shadow_word_death)
	#mind_blast,if=talent.legacy_of_the_void.enabled&(insanity<=81|(insanity<=75.2&talent.fortress_of_the_mind.enabled))
	if Talent(legacy_of_the_void_talent) and { Insanity() <= 81 or Insanity() <= 75.2 and Talent(fortress_of_the_mind_talent) } Spell(mind_blast)
	#mind_blast,if=!talent.legacy_of_the_void.enabled|(insanity<=96|(insanity<=95.2&talent.fortress_of_the_mind.enabled))
	if not Talent(legacy_of_the_void_talent) or Insanity() <= 96 or Insanity() <= 95.2 and Talent(fortress_of_the_mind_talent) Spell(mind_blast)
	#shadow_word_pain,if=!ticking,cycle_targets=1
	if not target.DebuffPresent(shadow_word_pain_debuff) Spell(shadow_word_pain)
	#vampiric_touch,if=!ticking,cycle_targets=1
	if not target.DebuffPresent(vampiric_touch_debuff) Spell(vampiric_touch)
	#mind_flay,if=!talent.mind_spike.enabled,interrupt=1,chain=1
	if not Talent(mind_spike_talent) Spell(mind_flay)
	#mind_spike,if=talent.mind_spike.enabled
	if Talent(mind_spike_talent) Spell(mind_spike)
	#shadow_word_pain
	Spell(shadow_word_pain)
}

AddFunction ShadowMainShortCdActions
{
	#mindbender,if=talent.mindbender.enabled
	if Talent(mindbender_talent) Spell(mindbender)

	unless target.DebuffRemaining(shadow_word_pain_debuff) < { 3 + 4 / 3 } * GCD() and Spell(shadow_word_pain) or target.DebuffRemaining(vampiric_touch_debuff) < { 4 + 4 / 3 } * GCD() and Spell(vampiric_touch)
	{
		#shadow_crash,if=talent.shadow_crash.enabled
		if Talent(shadow_crash_talent) Spell(shadow_crash)
		#mindbender,if=talent.mindbender.enabled&set_bonus.tier18_2pc
		if Talent(mindbender_talent) and ArmorSetBonus(T18 2) Spell(mindbender)

		unless not target.DebuffPresent(shadow_word_pain_debuff) and Talent(legacy_of_the_void_talent) and Insanity() >= 70 and Spell(shadow_word_pain) or not target.DebuffPresent(vampiric_touch_debuff) and Talent(legacy_of_the_void_talent) and Insanity() >= 70 and Spell(vampiric_touch) or not Talent(reaper_of_souls_talent) and SpellChargeCooldown(shadow_word_death) == 2 and Insanity() <= 90 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and SpellChargeCooldown(shadow_word_death) == 2 and Insanity() <= 70 and Spell(shadow_word_death) or Talent(legacy_of_the_void_talent) and { Insanity() <= 81 or Insanity() <= 75.2 and Talent(fortress_of_the_mind_talent) } and Spell(mind_blast) or { not Talent(legacy_of_the_void_talent) or Insanity() <= 96 or Insanity() <= 95.2 and Talent(fortress_of_the_mind_talent) } and Spell(mind_blast) or not target.DebuffPresent(shadow_word_pain_debuff) and Spell(shadow_word_pain) or not target.DebuffPresent(vampiric_touch_debuff) and Spell(vampiric_touch)
		{
			#shadow_word_void,if=(insanity<=70&talent.legacy_of_the_void.enabled)|(insanity<=85&!talent.legacy_of_the_void.enabled)
			if Insanity() <= 70 and Talent(legacy_of_the_void_talent) or Insanity() <= 85 and not Talent(legacy_of_the_void_talent) Spell(shadow_word_void)
		}
	}
}

AddFunction ShadowMainCdActions
{
	#surrender_to_madness,if=talent.surrender_to_madness.enabled&target.health.pct<30
	if Talent(surrender_to_madness_talent) and target.HealthPercent() < 30 Spell(surrender_to_madness)

	unless Talent(mindbender_talent) and Spell(mindbender) or target.DebuffRemaining(shadow_word_pain_debuff) < { 3 + 4 / 3 } * GCD() and Spell(shadow_word_pain) or target.DebuffRemaining(vampiric_touch_debuff) < { 4 + 4 / 3 } * GCD() and Spell(vampiric_touch)
	{
		#void_eruption,if=insanity>=85|(talent.auspicious_spirits.enabled&insanity>=(80-shadowy_apparitions_in_flight*4))
		if Insanity() >= 85 or Talent(auspicious_spirits_talent) and Insanity() >= 80 - 1 * 4 Spell(void_eruption)
	}
}

### actions.precombat

AddFunction ShadowPrecombatMainActions
{
	#mind_blast
	Spell(mind_blast)
}

AddFunction ShadowPrecombatShortCdPostConditions
{
	Spell(mind_blast)
}

AddFunction ShadowPrecombatCdActions
{
	#flask,type=greater_draenic_intellect_flask
	#food,type=pickled_eel
	#snapshot_stats
	#potion,name=draenic_intellect
	# ShadowUsePotionIntellect()
}

AddFunction ShadowPrecombatCdPostConditions
{
	Spell(mind_blast)
}

### actions.s2m

AddFunction ShadowS2mMainActions
{
	#void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd,cycle_targets=1
	if target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() Spell(void_bolt)
	#void_bolt
	Spell(void_bolt)
	#shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+30)<100
	if not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 Spell(shadow_word_death)
	#shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+90)<100
	if Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 90 < 100 Spell(shadow_word_death)
	#mind_blast
	Spell(mind_blast)
	#shadow_word_death,if=cooldown.shadow_word_death.charges=2
	if SpellChargeCooldown(shadow_word_death) == 2 Spell(shadow_word_death)
	#shadow_word_pain,if=!ticking,cycle_targets=1
	if not target.DebuffPresent(shadow_word_pain_debuff) Spell(shadow_word_pain)
	#vampiric_touch,if=!ticking,cycle_targets=1
	if not target.DebuffPresent(vampiric_touch_debuff) Spell(vampiric_touch)
	#wait,sec=cooldown.void_bolt.remains,if=cooldown.void_bolt.remains<(gcd.max*0.75)
	unless SpellCooldown(void_bolt) < GCD() * 0.75 and SpellCooldown(void_bolt) > 0
	{
		#mind_flay,if=!talent.mind_spike.enabled,interrupt=1,chain=1
		if not Talent(mind_spike_talent) Spell(mind_flay)
		#mind_spike,if=talent.mind_spike.enabled
		if Talent(mind_spike_talent) Spell(mind_spike)
		#shadow_word_pain
		Spell(shadow_word_pain)
	}
}

AddFunction ShadowS2mShortCdActions
{
	#shadow_crash,if=talent.shadow_crash.enabled
	if Talent(shadow_crash_talent) Spell(shadow_crash)
	#mindbender,if=talent.mindbender.enabled
	if Talent(mindbender_talent) Spell(mindbender)

	unless target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt)
	{
		#void_torrent
		Spell(void_torrent)

		unless not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 90 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death)
		{
			#shadow_word_void,if=(insanity-(current_insanity_drain*gcd.max)+75)<100
			if Insanity() - CurrentInsanityDrain() * GCD() + 75 < 100 Spell(shadow_word_void)
		}
	}
}

AddFunction ShadowS2mShortCdPostConditions
{
	target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt) or not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 90 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death) or not target.DebuffPresent(shadow_word_pain_debuff) and Spell(shadow_word_pain) or not target.DebuffPresent(vampiric_touch_debuff) and Spell(vampiric_touch) or not { SpellCooldown(void_bolt) < GCD() * 0.75 and SpellCooldown(void_bolt) > 0 } and { not Talent(mind_spike_talent) and Spell(mind_flay) or Talent(mind_spike_talent) and Spell(mind_spike) or Spell(shadow_word_pain) }
}

AddFunction ShadowS2mCdActions
{
	unless Talent(shadow_crash_talent) and Spell(shadow_crash) or Talent(mindbender_talent) and Spell(mindbender)
	{
		#dispersion,if=!buff.power_infusion.up&!buff.berserking.up&!buff.bloodlust.up
		if not BuffPresent(power_infusion_buff) and not BuffPresent(berserking_buff) and not BuffPresent(burst_haste_buff any=1) and target.Classification(worldboss) Spell(dispersion)
		#power_infusion,if=buff.voidform.stack>=10
		if BuffStacks(voidform_buff) >= 10 Spell(power_infusion)
		#berserking,if=buff.voidform.stack>=10
		if BuffStacks(voidform_buff) >= 10 Spell(berserking)

		unless target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt) or Spell(void_torrent) or not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 90 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death)
		{
			#shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
			if BuffStacks(voidform_buff) > 15 Spell(shadowfiend)
		}
	}
}

AddFunction ShadowS2mCdPostConditions
{
	Talent(shadow_crash_talent) and Spell(shadow_crash) or Talent(mindbender_talent) and Spell(mindbender) or target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt) or Spell(void_torrent) or not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 90 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death) or Insanity() - CurrentInsanityDrain() * GCD() + 75 < 100 and Spell(shadow_word_void) or not target.DebuffPresent(shadow_word_pain_debuff) and Spell(shadow_word_pain) or not target.DebuffPresent(vampiric_touch_debuff) and Spell(vampiric_touch) or not { SpellCooldown(void_bolt) < GCD() * 0.75 and SpellCooldown(void_bolt) > 0 } and { not Talent(mind_spike_talent) and Spell(mind_flay) or Talent(mind_spike_talent) and Spell(mind_spike) or Spell(shadow_word_pain) }
}

### actions.vf

AddFunction ShadowVfMainActions
{
	#void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd,cycle_targets=1
	if target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() Spell(void_bolt)
	#void_bolt
	Spell(void_bolt)
	#shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+10)<100
	if not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 10 < 100 Spell(shadow_word_death)
	#shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+30)<100
	if Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 Spell(shadow_word_death)
	#mind_blast
	Spell(mind_blast)
	#shadow_word_death,if=cooldown.shadow_word_death.charges=2
	if SpellChargeCooldown(shadow_word_death) == 2 Spell(shadow_word_death)
	#shadow_word_pain,if=!ticking,cycle_targets=1
	if not target.DebuffPresent(shadow_word_pain_debuff) Spell(shadow_word_pain)
	#vampiric_touch,if=!ticking,cycle_targets=1
	if not target.DebuffPresent(vampiric_touch_debuff) Spell(vampiric_touch)
	#wait,sec=cooldown.void_bolt.remains,if=cooldown.void_bolt.remains<(gcd.max*0.75)
	unless SpellCooldown(void_bolt) < GCD() * 0.75 and SpellCooldown(void_bolt) > 0
	{
		#mind_flay,if=!talent.mind_spike.enabled,interrupt=1,chain=1
		if not Talent(mind_spike_talent) Spell(mind_flay)
		#mind_spike,if=talent.mind_spike.enabled
		if Talent(mind_spike_talent) Spell(mind_spike)
		#shadow_word_pain
		Spell(shadow_word_pain)
	}
}

AddFunction ShadowVfShortCdActions
{
	#shadow_crash,if=talent.shadow_crash.enabled
	if Talent(shadow_crash_talent) Spell(shadow_crash)
	#mindbender,if=talent.mindbender.enabled
	if Talent(mindbender_talent) Spell(mindbender)

	unless target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt)
	{
		#void_torrent
		Spell(void_torrent)

		unless not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 10 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death)
		{
			#shadow_word_void,if=(insanity-(current_insanity_drain*gcd.max)+25)<100
			if Insanity() - CurrentInsanityDrain() * GCD() + 25 < 100 Spell(shadow_word_void)
		}
	}
}

AddFunction ShadowVfShortCdPostConditions
{
	target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt) or not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 10 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death) or not target.DebuffPresent(shadow_word_pain_debuff) and Spell(shadow_word_pain) or not target.DebuffPresent(vampiric_touch_debuff) and Spell(vampiric_touch) or not { SpellCooldown(void_bolt) < GCD() * 0.75 and SpellCooldown(void_bolt) > 0 } and { not Talent(mind_spike_talent) and Spell(mind_flay) or Talent(mind_spike_talent) and Spell(mind_spike) or Spell(shadow_word_pain) }
}

AddFunction ShadowVfCdActions
{
	#surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&(cooldown.void_bolt.up|cooldown.void_torrent.up|cooldown.shadow_word_death.up|buff.shadowy_insight.up)&target.health.pct<30
	if Talent(surrender_to_madness_talent) and Insanity() >= 25 and { not SpellCooldown(void_bolt) > 0 or not SpellCooldown(void_torrent) > 0 or not SpellCooldown(shadow_word_death) > 0 or BuffPresent(shadowy_insight_buff) } and target.HealthPercent() < 30 Spell(surrender_to_madness)

	unless Talent(shadow_crash_talent) and Spell(shadow_crash) or Talent(mindbender_talent) and Spell(mindbender)
	{
		#dispersion,if=!buff.power_infusion.up&!buff.berserking.up&!buff.bloodlust.up
		if not BuffPresent(power_infusion_buff) and not BuffPresent(berserking_buff) and not BuffPresent(burst_haste_buff any=1) and target.Classification(worldboss) Spell(dispersion)
		#power_infusion,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=30
		if BuffStacks(voidform_buff) >= 10 and BuffStacks(insanity_drain_stacks_buff) <= 30 Spell(power_infusion)
		#berserking,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20
		if BuffStacks(voidform_buff) >= 10 and BuffStacks(insanity_drain_stacks_buff) <= 20 Spell(berserking)

		unless target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt) or Spell(void_torrent) or not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 10 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death)
		{
			#shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
			if BuffStacks(voidform_buff) > 15 Spell(shadowfiend)
		}
	}
}

AddFunction ShadowVfCdPostConditions
{
	Talent(shadow_crash_talent) and Spell(shadow_crash) or Talent(mindbender_talent) and Spell(mindbender) or target.DebuffRemaining(shadow_word_pain_debuff) < 3.5 * GCD() and Spell(void_bolt) or Spell(void_bolt) or Spell(void_torrent) or not Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 10 < 100 and Spell(shadow_word_death) or Talent(reaper_of_souls_talent) and CurrentInsanityDrain() * GCD() > Insanity() and Insanity() - CurrentInsanityDrain() * GCD() + 30 < 100 and Spell(shadow_word_death) or Spell(mind_blast) or SpellChargeCooldown(shadow_word_death) == 2 and Spell(shadow_word_death) or Insanity() - CurrentInsanityDrain() * GCD() + 25 < 100 and Spell(shadow_word_void) or not target.DebuffPresent(shadow_word_pain_debuff) and Spell(shadow_word_pain) or not target.DebuffPresent(vampiric_touch_debuff) and Spell(vampiric_touch) or not { SpellCooldown(void_bolt) < GCD() * 0.75 and SpellCooldown(void_bolt) > 0 } and { not Talent(mind_spike_talent) and Spell(mind_flay) or Talent(mind_spike_talent) and Spell(mind_spike) or Spell(shadow_word_pain) }
}
]]

	OvaleScripts:RegisterScript("PRIEST", "shadow", name, desc, code, "script")
end
