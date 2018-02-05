#region Control Input
global.left = (
keyboard_check(ord("A"))
);

global.right = (
keyboard_check(ord("D"))
);

global.jump = (
keyboard_check_pressed(ord("W"))
or keyboard_check_pressed(vk_space)
);

global.jumpReleased = (
keyboard_check_released(ord("W"))
or keyboard_check_released(vk_space)
);

global.attack = (
keyboard_check_pressed(ord("K"))
);

global.pause = (
keyboard_check_pressed(ord("P"))
);

global.escape = (
keyboard_check_pressed(vk_escape)
);

global.sprint = (
keyboard_check(vk_shift)
);
#endregion Control Input
#region Damage Taken
if (global.damageTaken){
	global.freezeFrame = true;
	freezeFrameTimer += 1;
	if (freezeFrameTimer == freezeFrameTimePlayerDamage){
		freezeFrameTimer = 0;
		global.freezeFrame = false;
		global.damageTaken = false;
	}	
}
#endregion Damage Taken
#region Debug
if (keyboard_check_pressed(vk_f10)){
    debug = !debug;
}

if (debug == true){
    if (keyboard_check_pressed(ord("R"))){
        room_restart();
    }
    
    if (mouse_check_button(mb_left)){
        obj_player.x = mouse_x;
        obj_player.y = mouse_y;
    }
    
    if (keyboard_check_pressed(ord("M"))){
        obj_player.jumpReleaseSpeed += 1;
    }
    
    if (keyboard_check_pressed(ord("N"))){
        obj_player.jumpReleaseSpeed -= 1;
    }
}
#endregion Debug