def selects_most_frequent_attacker
  "SELECT battles.attacker_1, COUNT (attacker_1) FROM battles GROUP BY attacker_1 ORDER BY COUNT (attacker_1) DESC LIMIT 3"
end

def selects_attacker_who_loses_the_most
  "SELECT battles.attacker_1, COUNT (attacker_1) FROM battles WHERE battles.attacker_outcome = 'loss' GROUP BY attacker_1 ORDER BY COUNT (attacker_1) DESC LIMIT 1"
end

def selects_most_common_battle_type
  "SELECT battles.battle_type, COUNT (battle_type) FROM battles GROUP BY battle_type ORDER BY COUNT (battle_type) DESC LIMIT 1"
end

def selects_most_frequent_battle_location
  "SELECT battles.location COUNT (location)FROM battles GROUP BY location ORDER BY COUNT (location) DESC LIMIT 3"
end

def selects_battles_attackers_lost_where_attackers_outnumbered_defenders
  "SELECT battles.name FROM battles WHERE battles.attacker_size > battles.defender_size AND battles.attacker_outcome = 'loss'"
end

# - Who attacks most often? (Not attacker king, general attacker)
# - Which attacker most often loses a battle? (Not attacker king, general attacker)
# - What is the most common type of battle?
# - What location has seen the most amount of battles?
# - List the battles attackers lost where attackers outnumbered defenders
