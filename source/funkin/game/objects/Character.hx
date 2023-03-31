package funkin.game.objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.game.objects.backgrounds.TankmenBG;
import funkin.game.PlayState;
import funkin.game.Section.SwagSection;
import funkin.system.Paths;
import funkin.utils.*;
import flixel.util.FlxTimer;

using StringTools;
class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;
	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var animationNotes:Array<Dynamic> = [];
	public var posOffset:Array<Dynamic> = [0,0];
	public var dontDance:Bool = false;
	public var danceLeftAndRight:Bool = false;
	public var holdTimer:Float = 0;
	
	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;

		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('gameObjects/characters/gf/Girlfriend');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, true);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24, true);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('gameObjects/characters/gf/limo/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('idleHair', 'GF Dancing Beat Hair blowing CAR', [10, 11, 12, 25, 26, 27], "", 24, true);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('gameObjects/characters/dad/DADDY_DEAREST');
				frames = tex;
				quickAnimAdd('idle', 'Dad idle dance');
				quickAnimAdd('singUP', 'Dad Sing Note UP');
				quickAnimAdd('singRIGHT', 'Dad Sing Note RIGHT');
				quickAnimAdd('singDOWN', 'Dad Sing Note DOWN');
				quickAnimAdd('singLEFT', 'Dad Sing Note LEFT');

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'skippa':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('gameObjects/characters/skippa/skippa');
				frames = tex;
				quickAnimAdd('idle', 'Skipper Idle');
				quickAnimAdd('singUP', 'Skipper Up');
				quickAnimAdd('singRIGHT', 'Skipper Right');
				quickAnimAdd('singDOWN', 'Skipper Down');
				quickAnimAdd('singLEFT', 'Skipper Left');
	
				loadOffsetFile(curCharacter);
	
				playAnim('idle');	

			case 'ego-skippa':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('gameObjects/characters/skippa/prejudice/EgoSkippa');
				frames = tex;
				quickAnimAdd('idle', 'Skipper Idle');
				quickAnimAdd('singUP', 'Skipper Up');
				quickAnimAdd('singRIGHT', 'Skipper Right');
				quickAnimAdd('singDOWN', 'Skipper Down');
				quickAnimAdd('singLEFT', 'Skipper Left');
		
				loadOffsetFile(curCharacter);
		
				playAnim('idle');					

			case 'bf':
				tex = Paths.getSparrowAtlas('gameObjects/characters/bf/Boyfriend');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				animation.addByPrefix('scared', 'BF idle shaking', 24, true);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;	

			case 'bf-dead':
				tex = Paths.getSparrowAtlas('gameObjects/characters/bf/Boyfriend_Dead');
				frames = tex;
				quickAnimAdd('firstDeath', "BF dies");
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				quickAnimAdd('deathConfirm', "BF Dead confirm");
	
				loadOffsetFile(curCharacter);
	
				playAnim('firstDeath');
	
				flipX = true;

			case 'bf-car':
				tex = Paths.getSparrowAtlas('gameObjects/characters/bf/limo/bfCar');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');

				animation.addByIndices('idleHair', 'BF idle dance', [10, 11, 12, 13], '', 24, true);
				
				loadOffsetFile(curCharacter);
				
				playAnim('idle');

				flipX = true;
		}

		dance();
		animation.finish();

		if (isPlayer) //removed most of the unesesscary code that ninjamuffin left
		{
			flipX = !flipX;
		}
	}

	function loadMappedAnims()
	{
		var sections:Array<SwagSection> = Song.loadFromJson('picospeaker', 'stress').notes;
		for (section in sections)
		{
			for (note in section.sectionNotes)
			{
				animationNotes.push(note);
			}
		}
		TankmenBG.animationNotes = animationNotes;
		animationNotes.sort(sortAnims);
	}

	function sortAnims(x, y)
	{
		return x[0] < y[0] ? -1 : x[0] > y[0] ? 1 : 0;
	}

	function quickAnimAdd(Name:String, Prefix:String)
	{
		animation.addByPrefix(Name, Prefix, 24, false);
	}

	function loadOffsetFile(char:String)
	{
		var offsets:Array<String> = CoolUtil.coolTextFile(Paths.file('funkin/data/character-data/chars/' + char + '-data.json', TEXT, null));
		for (i in offsets)
		{
			var split = i.split(' ');
			addOffset(split[0], Std.parseInt(split[1]), Std.parseInt(split[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}
		
		if (curCharacter.endsWith('-car') && !animation.curAnim.name.startsWith('sing') && animation.curAnim.finished)
		{
			playAnim('idleHair');
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'pico-speaker':
				if (animationNotes.length > 0 && Conductor.songPosition > animationNotes[0][0])
				{
					var shotDirection:Int = 1;
					if (animationNotes[0][1] >= 2)
					{
						shotDirection = 3;
					}
					shotDirection += FlxG.random.int(0, 1);
					
					playAnim('shoot' + shotDirection, true);
					animationNotes.shift();
				}
				if (animation.curAnim.finished)
				{
					playAnim(animation.curAnim.name, false, false, animation.curAnim.frames.length - 3);
				}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-car' | 'gf-christmas' | 'gf-pixel' | 'gf-tankmen':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'pico-speaker':
					// do nothing LOL
				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'tankman':
					if (!animation.curAnim.name.endsWith('DOWN-alt'))
						playAnim('idle');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
