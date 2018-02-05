#region Draw Player Health
//Draw unshaded health pockets
for (i = 0; i < obj_player.healthMax; i++){	
	draw_sprite(spr_health, 1, drawHealthX, (view_hport[0] - (drawHealthSpaceX + sprite_get_height(spr_health))));
	drawHealthX += (drawHealthSpaceX + sprite_get_width(spr_health));
}

drawHealthX = drawHealthSpaceX;

for (i = 0; i < obj_player.healthCurrent; i++){	
	draw_sprite(spr_health, 0, drawHealthX, (view_hport[0] - (drawHealthSpaceX + sprite_get_height(spr_health))));
	drawHealthX += (drawHealthSpaceX + sprite_get_width(spr_health));
}

drawHealthX = drawHealthSpaceX;
#endregion Draw Player Health
#region Debug

if (debug){
    draw_text(50, 50, obj_player.testCase1);
    draw_text(50, 65, obj_player.iFrameTimer);
}

#endregion Debug