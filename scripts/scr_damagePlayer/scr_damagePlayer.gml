if !(obj_player.invincible){
	if (obj_player.healthCurrent - argument0 > 0){
		obj_player.healthCurrent -= argument0;
		obj_player.invincible = true;
		global.damageTaken = true;
	}else{
		obj_player.healthCurrent = 0;
		global.playerDead = true;
	}
}