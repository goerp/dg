package nl.goerp.location 
{
	import flash.geom.Point;
	import nl.goerp.Prerequisitable;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Connection implements Prerequisitable
	{
		public static const BUS_SPEED:Number = 50;
		public static const BOAT_SPEED:Number = 20;
		public static const PLANE_SPEED:uint = 400;
		public static const WALK_SPEED:uint = 5;
		public static const SWIM_SPEED:uint = 1;
		
		public var from:Harbor;
		public var to:Harbor;
		public var transportType:String;
		public var cost:uint;
		public var departTime:uint;
		public var timeBetweenDeparts:uint;
		public function Connection(from:Harbor, to:Harbor, transportType:String, cost:uint, departTime:uint, timeBetweenDeparts:uint) 
		{
			this.cost = cost;
			this.from = from;
			this.to = to;
			this.transportType = transportType;
			this.departTime = departTime;
			this.timeBetweenDeparts = timeBetweenDeparts;
		}
		public function possible():Boolean{
			return (
			(World.player.money >= cost) && 
			(World.currentLocation == from) && 
			(World.day(Math.floor(World.currentTime) % timeBetweenDeparts) == World.day(departTime))); //last comparison: 
		}
		public function duration():Number{
			switch (transportType){
				case "bus":
						return (new Point(from.x - to.x, from.y - to.y).length) / BUS_SPEED;
					break;
				case "plane":
						return (new Point(from.x - to.x, from.y - to.y).length) / PLANE_SPEED;
					break;
				case "boat":
					return (new Point(from.x - to.x, from.y - to.y).length) / BOAT_SPEED;
					break;
					
				case "walking":
					return (new Point(from.x - to.x, from.y - to.y).length) / WALK_SPEED;
					break;
				case "swimming":
					return (new Point(from.x - to.x, from.y - to.y).length) / SWIM_SPEED;
					break;
			}
			return null;
		}

		
	}

}