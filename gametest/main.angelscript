/*
 Hello world!
*/

#include "eth_util.angelscript"

void main()
{
	LoadScene("scenes/ship1.esc", "", "onSceneUpdate");
}

void onSceneUpdate()
{
	//DrawText(vector2(0, 0), "No matter what the FPS rate is,\nthe ship speed will remain the same", "Verdana20.fnt", 0xFFFFFFFF);
}


// the function name must match the entity file name (spaceship.ent -> ETHCallback_spaceship)
void ETHCallback_ship(ETHEntity@ thisEntity)
{
	ETHInput@ input = GetInputHandle();

	// computes the distance our ship must move in order to keep
	// a speed of 60 pixels per second
	float speed = UnitsPerSecond(120.0f);

	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.AddToPositionXY(vector2(1.0f, 0.0f) * speed);
	}

	if (input.KeyDown(K_LEFT))
	{
		thisEntity.AddToPositionXY(vector2(-1.0f, 0.0f) * speed);
	}

	if (input.KeyDown(K_UP))
	{
		thisEntity.AddToPositionXY(vector2(0.0f,-1.0f) * speed);
	}

	if (input.KeyDown(K_DOWN))
	{
		thisEntity.AddToPositionXY(vector2(0.0f, 1.0f) * speed);
	}

	if (input.GetKeyState(K_SPACE) == KS_HIT)
	{
		AddEntity("shot.ent", thisEntity.GetPosition());
	}
}

void ETHCallback_shot(ETHEntity@ thisEntity)
{
	float speed = UnitsPerSecond(360.0f);
	thisEntity.AddToPositionXY(vector2(1.0f,0.0f) * speed);

	// if the projectile goes out of the screen view, delete it
	if (thisEntity.GetPosition().x < 0.0f)
	{
		DeleteEntity(thisEntity);
		print("projectile removed because it is no longer visible: ID " + thisEntity.GetID());
	}
}

void ETHCallback_sea(ETHEntity@ thisEntity)
{
	thisEntity.AddToPosition(vector3(-1,0,0));
}