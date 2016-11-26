package 
{
	import flash.ui.KeyLocation;
	import nl.goerp.Map;
	import nl.goerp.Player;
	import nl.goerp.location.Harbor;
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
		
		public static var harbors:Vector.<Harbor> = new Vector.<Harbor>;
		
		public static const WORLD_WIDTH:uint = 40000;
		
		public static function day(time:Number):Boolean{
			return Math.floor(time / 24);
		}
		public static function getHarborByPos(x:uint, y:uint):Harbor{
			for each(var h:Harbor in harbors){
				if (Math.floor(h.x / 100) == x && Math.floor(h.y / 100) == y) return h;
			}
			return null;
		}
		public function World() 
		{
			
		}
		
	}

}