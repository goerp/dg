package nl.goerp.location 
{
	import nl.goerp.Option;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Harbor extends Location
	{
		
		public var name:String;
		public var connections:Vector.<Connection> = new Vector.<Connection>;
		public function Harbor(x:uint, y:uint, name:String) 
		{
			super(x,y);
			this.name = name;
			
		}
		
		override public function getOptions():Vector.<Option>{
			var options:Vector.<Option> = new Vector.<Option>;
			for each(var c:Connection in connections){
				if (c.possible()){
					options.push(c);
				}
			}
			return options;
		}
		
	}

}