#if polymod
import polymod.backends.OpenFLBackend;
import polymod.backends.PolymodAssets.PolymodAssetType;
import polymod.format.ParseRules.LinesParseFormat;
import polymod.format.ParseRules.TextFileFormat;
import polymod.Polymod;
#end

// Kade Engine 1.8 is awesome, now I can use polymod.
class ModCore
{
	static final API_VERSION = "0.1.0";
	
	public static final MOD_DIRECTORY = "mods";
	public static final REL_MOD_DIRECTORY = "./mods";
	
	public static function initialize()
	{
		#if polymod
		trace("yoooooo what's good i'm initializing polymod");
		loadModsById(getModIds());
		#else
		trace("...you don't have polymod!!!! SCRAM!!!");
		#end
	}
	
	#if polymod
	static inline function polymodFramework():polymod.FrameworkParams
	{
		return {
			assetLibraryPaths: [
				"default" => "./preload", // ./preload
				"songs" => "./songs", "shared" => "./", "tutorial" => "./tutorial",
				"week1" => "./week1", "week2" => "./week2", "week3" => "./week3", "week4" => "./week4", "week5" => "./week5", "week6" => "./week6", "week7" => "./week7"
			]
		}
	}
	
	public static function loadModsById(ids:Array<String>)
	{
		var loadedModList = polymod.Polymod.init({modRoot: MOD_DIRECTORY, dirs: ids, framework: OPENFL, apiVersionRule: API_VERSION, frameworkParams: polymodFramework()});
		trace('Ayyy! Loading complete. We just loaded ${loadedModList.length} / ${ids.length} mods!');
		
		for (mod in loadedModList)
			trace('  * ${mod.title} v${mod.modVersion} [${mod.id}]');
		
		var fileList:Array<String> = Polymod.listModFiles("IMAGE");
		trace('Installed mods have replaced ${fileList.length} images.');
		for (item in fileList)
			trace('  * $item');

		fileList = Polymod.listModFiles("TEXT");
		trace('Installed mods have replaced ${fileList.length} text files.');
		for (item in fileList)
			trace('  * $item');

		fileList = Polymod.listModFiles("MUSIC");
		trace('Installed mods have replaced ${fileList.length} music files.');
		for (item in fileList)
			trace('  * $item');

		fileList = Polymod.listModFiles("SOUND");
		trace('Installed mods have replaced ${fileList.length} sound files.');
		for (item in fileList)
			trace('  * $item');
	}
	
	static function getModIds():Array<String>
	{
		trace('Lookin\' for mods in the mods folder...');
		var modMetadata = Polymod.scan({
			modRoot: "./mods"
		});
		trace('Found ${modMetadata.length} mods when scanning!');
		var modIds = [for (i in modMetadata) i.id];
		return modIds;
	}
	#end
}