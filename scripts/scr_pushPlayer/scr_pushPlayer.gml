//argument0 = Horizontal Speed
//argument1 = Horizontal Direction
//argument2 = Vertical Speed
//argument3 = Vertical Direction
//argument4 = Add (0) or Set (1)
if (argument4){
	obj_player.hSpeed = (argument0 * argument1);
	obj_player.vSpeed = (argument2 * argument3);
}else{
	obj_player.hSpeed += (argument0 * argument1);
	obj_player.vSpeed += (argument2 * argument3);
}