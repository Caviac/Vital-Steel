#region Pause Check
if (global.gamePaused or global.freezeFrame){
    exit;
}
#endregion Pause Check
#region Contact Checks
//Checks if the player is grounded
contactFloor = (!place_free(x, y + 1));

//Checks if the player is touching a ceiling
contactCeiling = (!place_free(x, y - 1));

//Checks if the player is touching a wall
contactWall = ((!place_free(x + 1, y)) or (!place_free(x - 1, y)))

//Checks if the player is touching anything
contactAny = (contactFloor or contactCeiling or contactWall);
#endregion Contact Checks
#region Movement
/*----------HORIZONTAL MOVEMENT----------*/
/*-----
hDirection:
1  = Player holding RIGHT
-1 = Player holding LEFT
0  = NO HORIZONTAL INPUT
-----*/
hDirection = (global.right - global.left);

//Sets hSpeedMax based on whether or not the player is sprinting.
if (global.sprint){
    hSpeedMax = hSpeedMaxSprint;
}else{
    hSpeedMax = hSpeedMaxWalk;
}

//Shoddy bug fix for a very specific situation when you hit the floor
if (contactFloor and !contactFloorLast and (abs(hSpeed) <= hSpeedMax) and (-(sign(hSpeed)) = hDirection)){
    hSpeed = hSpeedAcceleration * hDirection;
}

//Wallstick Timer Control (Needs to be above hSpeed code)
if (!place_free((x - hDirection), y) and !contactFloor){
    wallStickTimer += 1;
}else{
    wallStickTimer = 0;
}

if ((wallStickTimer <= 0) or (wallStickTimer >= wallStickTime)){
    wallStickActive = false;
}else{
    wallStickActive = true;
}


//Applies player input horizontal movement
if (hDirection == 1 and hDirectionLast != -1 and !wallStickActive and abs(hSpeed) <= hSpeedMax){
    if (hSpeed + hSpeedAcceleration < hSpeedMax){
        hSpeed += hSpeedAcceleration;
    }else{
        hSpeed = hSpeedMax;
    }
}else if (hDirection == -1 and hDirectionLast != 1 and !wallStickActive and abs(hSpeed) <= hSpeedMax){
    if (hSpeed - hSpeedAcceleration > -hSpeedMax){
        hSpeed -= hSpeedAcceleration;
		testCase1 = true;
    }else{
        hSpeed = -hSpeedMax;
		testCase1 = false;
    }
}else if (!contactFloor){
	if ((hDirection == 0) and ((hDirectionLast != 0) or (!contactWall and contactWallLast)) and (abs(hSpeed) <= hSpeedMaxSprint) and (abs(hSpeed) > hSpeedAirReleaseMax)){
			hSpeed = hSpeedAirReleaseMax * sign(hSpeed);
	}
    if (abs(hSpeed) > hSpeedDragLimit){
		if (abs(hSpeed) < hSpeedMax){
	        if (abs(hSpeed) - hSpeedNegativeAcceleration > hSpeedDragLimit){
	            hSpeed -= (hSpeedNegativeAcceleration * sign(hSpeed));
	        }else{
	            hSpeed = (hSpeedDragLimit * sign(hSpeed));
	        }
		}else if (hDirection = 0){
			hSpeed += hSpeedFriction * -(sign(hSpeed));
		}else{
			hSpeed += (hSpeedFriction + hSpeedAcceleration) * -(sign(hSpeed));
		}
    }
}else if ((abs(hSpeed) > hSpeedMax)){
	if (hDirection != 0 and hDirection = -(sign(hSpeed))){
		hSpeed += (hSpeedFriction + hSpeedAcceleration) * -(sign(hSpeed));
	}else{
		hSpeed += hSpeedFriction * -(sign(hSpeed));	
	}
}else{
    hSpeed = 0;
}

/*----------VERTICAL MOVEMENT----------*/
//Use a jump if the player walks off a ledge
if (!contactFloor and !contactWall and jumpCount == jumpCountMax){
    jumpCount -= 1;
}

//Reset jumps when on the floor
if (contactFloor){
    jumpCount = jumpCountMax;
}

//Jump
if (global.jump){
    if (contactWall and !contactFloor){ //Wall Jump
        if (!place_free(x + 1, y)){
            hSpeed = -wallJumphSpeed;
            jumpCount = jumpCountMax;
        }else if (!place_free(x - 1, y)){
            hSpeed = wallJumphSpeed;
            jumpCount = jumpCountMax;
        }
        doubleJumpActive = false;
        vSpeed = -wallJumpvSpeed
    }else if (jumpCount == jumpCountMax){
        vSpeed = -jumpSpeed;
    }else if (jumpCount > 0){
        doubleJumpActive = true;
        vSpeed = doubleJumpDifference;
		if ((sign(hSpeed) != hDirection) and (abs(hSpeed) <= hSpeedMax)){
			hSpeed = 0;
		}
    }
    if (!contactFloor and !contactWall){
        jumpCount -= 1;
    }
}

//Double Jump
if (doubleJumpActive){
    if (vSpeed - doubleJumpAcceleration > -jumpSpeed){
        vSpeed -= doubleJumpAcceleration;
    }else{
        vSpeed = -jumpSpeed;
        doubleJumpActive = false;
    }
}

//Cancels vertical speed when double jumping and touching a ceiling (kind of a lazy bug fix, pls don't touch)
if (doubleJumpActive and contactCeiling){
    doubleJumpActive = false;
    vSpeed = 0;
}

//Cancels vSpeed when jump is released
if (global.jumpReleased and doubleJumpActive){
    doubleJumpJumpReleasedTrigger = 1;
}

if (global.jumpReleased or doubleJumpJumpReleasedTrigger == 1){
    if (vSpeed < -jumpReleaseSpeed){
        vSpeed = -jumpReleaseSpeed;
        doubleJumpJumpReleasedTrigger = 0;
        doubleJumpActive = false;
    }
}

/*----------GRAVITY & WALLS----------*/
//Fall Speed
if (!contactFloor and !doubleJumpActive){
    if (!contactWall){
        if ((vSpeed + gravityAcceleration) < terminalVelocity){
            vSpeed += gravityAcceleration;
        }else{
            vSpeed = terminalVelocity;
        }
    }else if (!contactWallLast and (vSpeed > 0)){
        vSpeed = 0;
    }else if (vSpeed <= 0){
        vSpeed += gravityAcceleration;
    }else{
        if ((vSpeed + wallSlideAcceleration) < wallSlideMaxSpeed){
            vSpeed += wallSlideAcceleration;
        }else{
            vSpeed = wallSlideMaxSpeed;
        }
    }
}


//vSpeed safeguard (this should never be able to happen, but just in case)
if (vSpeed < -vSpeedMax){
    vSpeed = -vSpeedMax;
}

/*--------------------APPLY MOVEMENT--------------------*/
/*-----KEEP EVERYTHING BELOW THIS LINE AT THE BOTTOM----*/
//Applies horizontal movement
for(i = 0; i < abs(hSpeed); i++){
    if (place_free(x + sign(hSpeed), y)){
        x += sign(hSpeed);
    }else{
        hSpeed = 0;
    }
}

//Applies vertical movement
for(i = 0; i < abs(vSpeed); i++){
    if (place_free(x, y + sign(vSpeed))){
        y += sign(vSpeed);
    }else{
        vSpeed = 0;
    }
}
#endregion Movement 
#region iFrames
if (invincible == true){
	iFrameTimer += 1;
	if (iFrameTimer == iFramesMax){
		invincible = false;
		iFrameTimer = 0;
	}
}
#endregion iFrames