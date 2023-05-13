package;

import flixel.FlxG;
import flixel.FlxSprite;
import haxe.io.Path;
import shaderslmfao.ColorSwap;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap;
	
	public function new(x:Float, y:Float, noteData:Int = 0):Void
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('noteSplashes', null, true);

		animation.addByPrefix('note1-0', 'note impact 1  blue', 24, false);
		animation.addByPrefix('note2-0', 'note impact 1 green', 24, false);
		animation.addByPrefix('note0-0', 'note impact 1 purple', 24, false);
		animation.addByPrefix('note3-0', 'note impact 1 red', 24, false);
		animation.addByPrefix('note1-1', 'note impact 2 blue', 24, false);
		animation.addByPrefix('note2-1', 'note impact 2 green', 24, false);
		animation.addByPrefix('note0-1', 'note impact 2 purple', 24, false);
		animation.addByPrefix('note3-1', 'note impact 2 red', 24, false);
		
		setGraphicSize(Std.int(width));

		setupNoteSplash(x, y, noteData);

		// alpha = 0.75;
	}

	public function setupNoteSplash(x:Float, y:Float, noteData:Int = 0)
	{
		setPosition(x, y);
		alpha = 0.6;
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		colorSwap.update(Note.arrowColors[noteData]);

		animation.play('note' + noteData + '-' + FlxG.random.int(0, 1), true);
		var framePlunder:Int = FlxG.random.int(-2, 2);
		animation.curAnim.frameRate += framePlunder;
		if (animation.curAnim.frameRate < 12 || animation.curAnim.frameRate > 48) // Just because I don't want to have a frozen splash.
			animation.curAnim.frameRate -= framePlunder;
		updateHitbox();

		offset.set(width * 0.3, height * 0.3);
	}

	override function update(elapsed:Float)
	{
		if (animation.curAnim.finished)
			kill();

		super.update(elapsed);
	}
}
