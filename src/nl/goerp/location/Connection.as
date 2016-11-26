package nl.goerp.location 
{
	import nl.goerp.Prerequisitable;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Connection implements Prerequisitable
	{
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
		}
		public function possible():Boolean{
			return 
			(World.player.money >= cost) && 
			(World.currentLocation == from) && 
			(World.day(Math.floor(World.currentTime) % timeBetweenDeparts) == World.day(departTime)); //last comparison: 
		}

		
	}

}