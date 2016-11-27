package nl.goerp.location 
{
	import nl.goerp.Option;
	import nl.goerp.OptionDeliverable;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Location implements OptionDeliverable
	{
		public var x:uint;
		public var y:uint;
		public function Location(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y;
			
		}

		public function getOptions():Vector.<Option>{
			throw new Error("should be overridden");
			return null;
		}
		
	}

}