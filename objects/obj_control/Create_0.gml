#region Initiate Global Variables
global.gamePaused = false;
global.damageTaken = false;
global.playerDead = false;
global.freezeFrame = false;
#endregion Initiate Variables
#region Initiate Controls
global.left=0
global.right=0
global.jump=0
global.jumpReleased=0
global.attack=0
global.pause=0
global.escape=0
global.sprint=0
#endregion Initiate Controls
#region Initiate Variables
//Health
drawHealthSpaceX = 16;
drawHealthX = drawHealthSpaceX;

//Freeze Frame
freezeFrameTimer = 0;
freezeFrameTimePlayerDamage = 10;

//Debug
debug = false;
#endregion Initiate Variables