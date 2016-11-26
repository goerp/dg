package nl.goerp.location 
{
	/**
	 * ...
	 * @author Goerp
	 */
	public class Harbor extends Location 
	{
		
		public var name:String;
		public var landConnectedTo:Vector.<Harbor>=new Vector.<Harbor>
		public function Harbor(x:uint, y:uint, name:String) 
		{
			super(x,y);
			this.name = name;
			
		}
		
	}

}