package throwables;

import flixel.FlxG;
import flixel.FlxSprite;

class ComboSpr extends FlxSprite // For recycley purposes
{
	public var memory:Bool = true;
	
	public var live:Float = 1.0;
	
	public function new(?x:Float, ?y:Float, live:Float = 1.0)
	{
		super(x, y);
		
		setup(x, y, live);
	}
	
	public function setup(?x:Float, ?y:Float, live:Float = 1.0)
	{
		setPosition(x, y);
		
		acceleration.y = 0;
		velocity.y = 0;
		velocity.x = 0;
		
		this.live = live;
		
		alpha = 1;
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (this != null)
		{
			if (live > 0)
				live -= elapsed;
			
			if (live <= 0)
			{
				alpha -= elapsed / 0.2;
				
				if (alpha <= 0)
				{
					kill();
					if (!memory)
						destroy();
				}
			}
		}
	}
}