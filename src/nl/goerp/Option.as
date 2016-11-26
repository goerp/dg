package nl.goerp 
{
	
	/**
	 * ...
	 * @author Goerp
	 */
	public class Option implements Prerequisitable
	{
		private var checkFunction:Function;
		public function Option(checkFunction:Function) 
		{
			
			
		}
		
		public function possible():Boolean{
			return checkFunction();
		}
		
		

		
	}
	
}