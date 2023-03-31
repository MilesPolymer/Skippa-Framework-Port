package funkin.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import funkin.system.MathFunctions;
import funkin.system.Paths;

class StoryItem extends FlxSpriteGroup {
	public var targetY:Float = 0;
	public var week:FlxSprite;
	public var flashingInt:Int = 0;

	public function new(x:Float, y:Float, weekNum:Int = 0) {
		super(x, y);
		week = new FlxSprite().loadGraphic(Paths.image('menuObjects/storymenu/weeks/week' + weekNum));
		add(week);
	}

	private var isFlashing:Bool = false;

	public function startFlashing():Void {
		isFlashing = true;
	}

	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);

	override function update(elapsed:Float) {
		super.update(elapsed);
		y = MathFunctions.fixedLerp(y, (targetY * 120) + 480, 0.17);

		if (isFlashing)
			flashingInt += 1;

		if (flashingInt % fakeFramerate >= Math.floor(fakeFramerate / 2))
			week.color = 0xFF33ffff;
		else
			week.color = FlxColor.WHITE;
	}
}
