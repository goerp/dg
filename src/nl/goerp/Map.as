package nl.goerp 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Map 
	{
		public var heightMap:BitmapData = new BitmapData(400, 400,false,0);
		public var heightThreshold:uint=1000;
		public function Map() 
		{
			
		}
		public function buildHeightMap():void{
			var nrAtHeight:uint = 0;
			var x:int;
			var y:int;
			var dx:int;
			var dy:int;
			var dz:int;
			var xi:int;
			var yi:int;
			var max:uint = 0;
			var oldp:uint;
			var newp:uint;
			
			while (nrAtHeight < (160*400)){
				x = Math.floor(Math.random() * 400);
				y = Math.floor(Math.random() * 400);
				dx = Math.floor(Math.random() * 150)+40;
				dy = Math.floor(Math.random() * 150)+80;
				dz = Math.floor(Math.random() * 90)+90;
				for (xi = x - dx; xi <= x + dx; xi++){
					for (yi = y - dy; yi <= y + dy; yi++){
						if (xi >= 0 && xi < 400 && yi >= 0 && yi < 400){
							oldp = heightMap.getPixel(xi, yi);
							newp = (dz * 20 / (1 + Math.abs(xi - x) + Math.abs(yi - y))) + oldp;
							heightMap.setPixel(xi, yi, newp);
							if (newp > heightThreshold) {
								nrAtHeight++;
								if (newp> max) {
									max = newp;
								}
							}
						}
					}
					
				}
				
			}
			var newval:uint;
			var tval:uint;
			for (xi = 0; xi < 400; xi++){
				for (yi = 0; yi < 400; yi++){
					if (heightMap.getPixel(xi, yi) < heightThreshold){
						newval = heightMap.getPixel(xi, yi) * (256 / heightThreshold);
						if (newval > 255){
							trace("doh");
						}
						
					}else  if (heightMap.getPixel(xi, yi) == heightThreshold){
						newval = 0;;
					}else {
						tval = 127 + (128 * heightMap.getPixel(xi, yi) / max); 
						if (tval > 255){
							trace("doh");
						}

						newval = tval* 0x10000;
					}
					heightMap.setPixel(xi, yi, newval);
				}
				
			}
			
		}
		
	}

}