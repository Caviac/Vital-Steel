#region Constants
/*----------HORIZONTAL MOVEMENT----------*/
hSpeedMaxWalk = 6; //Walk speed in pixels per step
hSpeedMaxSprint = 8; //Sprint speed in pixels per step
hSpeedDragLimit = 0; //What the player's speed will fall to when not pressing a direction in the air
hSpeedAirReleaseMax = 4 //What the player's hSpeed will be set to when releasing a button in the air
hSpeedAcceleration = 1; //Acceleration of horizontal player movement
hSpeedNegativeAcceleration = 0.1; //How quickly the player slows down in the air when not holding a direction
hSpeedFriction = 1; //How quickly the player slowls down on the ground when going faster than max speed

/*----------VERTICAL MOVEMENT & JUMPING----------*/
vSpeedMax = 35; //Fastest the player can move upwards
gravityAcceleration = 0.8; //How quickly the player accelerates downwards while not standing on the ground
terminalVelocity = 12; //The fastest the player can fall in pixels per step
jumpSpeed = 12; //Initial vertical speed when jumping
jumpReleaseSpeed = 6; //Vertical speed to set player to when releasing jump if they are not already below it
jumpCountMax = 2; //The total number of jumps the player is allowed from a standing position
doubleJumpAcceleration = 2; //How quickly the player accelerates upwards while jumping mid-air
doubleJumpDifference = 6; //The fall speed the player is initially set to when jumping mid-air

/*----------WALL JUMPING & SLIDING----------*/
wallJumpvSpeed = 14; //Initial vertical speed when wall jumping
wallJumphSpeed = 8; //How quickly the player is pushed horizontally off of a wall when wall-jumping
wallSlideAcceleration = 0.2; //How quickly the player accelerates down a wall
wallSlideMaxSpeed = 6; //The fastest the player can fall when wall-sliding in pixels per step
wallStickTime = 10; //The number of frames the player should stick to the wall when holding away from it

/*----------PLAYER STATS----------*/
healthMax = 3;
swordChargeMax = 100;
iFramesMax = 60;

#endregion Constants
#region Utility Variables
//Controls
left = 0;
right = 0;
jump = 0;
jumpReleased = 0;
attack = 0;
pause = 0;
escape = 0;
sprint = 0;

//Utility
hDirection = 0;
hDirectionInput = 0;
hSpeed = 0;
vSpeed = 0;
grounded = 0;
contactFloor = 0;
contactCeiling = 0;
contactWall = 0;
contactAny = 0;
doubleJumpActive = 0;
hSpeedMax = 5;
jumpCount = 2;
doubleJumpJumpReleasedTrigger = 0;
wallStickActive = false;
wallStickTimer = 0;
healthCurrent = 3;
swordChargeCurrent = 0;
soulsCollected = 0;
iFrameTimer = 0;
invincible = 0;

//Step Checks
hDirectionLast = 0;
contactFloorLast = 0;
contactWallLast = 0;

//Debug
testCase1 = false;
#endregion Utility Variables