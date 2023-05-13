package shaderslmfao;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;

class ImageDuo
{
	public var shader(default, null):ImageDuoShader;
	public var otherImage(default, set):BitmapData;
	public var blendPercent(default, set):Float = 0;
	
	public function new(image:BitmapData, blendPercent:Float = 0)
	{
		shader = new ImageDuoShader();
		this.otherImage = image;
		this.blendPercent = blendPercent;
	}
	
	function set_otherImage(otherImage:BitmapData):BitmapData
	{
		shader.otherImage.input = otherImage;
		
		return otherImage;
	}
	
	function set_blendPercent(blendPercent:Float):Float
	{
		shader.blendPercent.value = [blendPercent];
		
		return blendPercent;
	}
}

class ImageDuoShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		
		uniform sampler2D otherImage;
		
		uniform float blendPercent;
		
		float lerp(float a, float b, float t)
		{
			return a + (b - a) * t;
		}
		
		vec4 colorLerp(vec4 a, vec4 b, float t)
		{
			float colR = lerp(a.r, b.r, t);
			float colG = lerp(a.g, b.g, t);
			float colB = lerp(a.b, b.b, t);
			float colA = lerp(a.a, b.a, t);
			
			return vec4(colR, colG, colB, colA);
		}
		
		void main()
		{
			vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
			vec4 otherColor = flixel_texture2D(otherImage, openfl_TextureCoordv);
			
			vec4 finalColor = colorLerp(color, otherColor, blendPercent);
			
			gl_FragColor = finalColor;
		}
	')
	
		public function new()
		{
			super();
		}
}