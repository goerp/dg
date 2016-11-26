package 
{
	import flash.ui.KeyLocation;
	import nl.goerp.Map;
	import nl.goerp.Player;
	import nl.goerp.location.Location;
	/**
	 * ...
	 * @author Goerp
	 */
	public class World 
	{
		public static var currentLocation:Location;
		/**
		 * currentTime is measured in hours, fraction of hours is possible
		 */
		public static var currentTime:Number;
		
		public static var player:Player;
		
		public static var map:Map = new Map;
		
		public static const WORLD_WIDTH:uint = 40000;
		
		public static function day(time:Number):Boolean{
			return Math.floor(time / 24);
		}
		
		public function World() 
		{
			
		}
		
	}

}