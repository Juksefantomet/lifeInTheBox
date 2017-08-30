# lifeInTheBox
Ruby GOSU - survival in the box, avoid the big meany and level up your avatar

idea by Juksefantomet

A Small game for testing ruby and gosu together

Game recap


2048x2048 - playfield box

1 boss - scales as players enter/level

players - level 1 - 200

	stats:
		hp - health pool of a player - dead on zero
		avoidance - a chance to completely avoid an attack
		name - your personal identifier
		
	movement:
		horizontal, vertical, diagonal
		
	skills:
		level 1: heal (12% of max hp) - 30 sec, cooldown - (KBspace)
		level 10: block (blocks 50% of incoming damage for 2 seconds) - 30 sec, cooldown - (KbB)
		
		level 20,30,40,50,60,70,80,90,100 - increase heal by 2% (total 30% heal)
		level 5,15,25,35,45,55,65,75,85,95,105,110 - increase base hp with 5 pt.
		level 110,120,130,140,150,160,170,180,190,200 - increase avoidance by 1% (max 10%)
		level 100,200 - increase duration of block by 1 sec.
		
	dynamics:
		players move around in the box and avoid the boss, if the boss collides with the players they take damage.
		boss fixates on a player for 10 seconds increasing movement speed when getting closer to the fixation timer end.
		the boss will take naps after performing a fixation charge, then roam for a little while before fixating on a new player
		
		the more players the more hp / dmg the boss deals
		
		all players gain xp when a player survives fixation and when a sleep cycle ends.
		
		deal damage to the boss by picking up random appearing objects.
		
		when the boss is dead, spawn in a new playfield and allow players 30 seconds of "level up time"
		
		increment boss difficulty also based on stage level.

	viewpoint:
		top view