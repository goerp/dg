package nl.goerp 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nl.goerp.location.Connection;
	import nl.goerp.location.Harbor;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Map 
	{
		public var heightMap:BitmapData = new BitmapData(400, 400,false,0xFF000001);
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
					}else {
						tval = 127 + (128 * heightMap.getPixel(xi, yi) / max); 
						if (tval > 255){
							trace("doh");
						}

						newval = tval* 0x100;
					}
					heightMap.setPixel(xi, yi, newval);
				}
				
			}
			for (xi = 1; xi < 399; xi++){
				for (yi = 1; yi < 399; yi++){
					if (heightMap.getPixel(xi, yi) !=0 && heightMap.getPixel(xi, yi) <256 && (
						heightMap.getPixel(xi+1,yi) >255||
						heightMap.getPixel(xi-1,yi) >255||
						heightMap.getPixel(xi,yi+1) >255||
						heightMap.getPixel(xi,yi-1) >255
					)){
						heightMap.setPixel(xi, yi, 0);
					}
				}
				
			}
			
			var nrHarbors:int = 0;
			while (nrHarbors < 50){
				x = 100*(Math.floor(Math.random() * 390)+5);
				y = 100 * (Math.floor(Math.random() * 390) + 5);

				if(heightMap.getPixel(x/100, y/100)==0){
					heightMap.setPixel(x/100, y/100, 0xFFFFFF);
					nrHarbors++; 
					World.harbors.push(new Harbor(x, y, ""));
				}
			}
			
			var connectionsMade:Number = 0;
			for each(var h:Harbor in World.harbors){
				
				var done:Boolean = false;
				var prevx:int = -1;
				var prevy:int = -1;
				x = Math.floor(h.x / 100);
				y = Math.floor(h.y / 100);
				var dxa:Array = [0, 1, 1, 1, 0, -1, -1, -1];
				var dya:Array = [ -1, -1, 0, 1, 1, 1, 0, -1];
				var curd:uint = 0;
				heightMap.setPixel(x , y, 0xFEFFFF);
				var firstStep:Boolean = true;
				/*
				while (!done){
					for (var ai:int = 0; ai < 8; ai++){
						curd++; 
						if( curd > 7) curd = 0;
						dx = dxa[curd];
						dy = dya[curd];
						if ((heightMap.getPixel(x + dx, y + dy) == 0 || heightMap.getPixel(x + dx, y + dy) == 0xFFFFFF || heightMap.getPixel(x + dx, y + dy) == 0xFEFFFF) ){
							if (heightMap.getPixel(x+dx, y+dy) == 0xFFFFFF){
								h.connections.push(new Connection(h, World.getHarborByPos(x + dx, y + dy), "bus", (new Point(h.x - x - dx, h.y - y - dy)).length, Math.floor(Math.random() * 24 * 7), Math.floor(Math.random() * 7) * 24));
								connectionsMade++;
							}else if (heightMap.getPixel(x + dx, y + dy) == 0xFEFFFF){
								done = true;
							} else{
								heightMap.setPixel(x + dx, y + dy, 0xFF0000);
							}
							prevx = x;
							prevy = y;
							x = x + dx;
							y = y + dy;
							break;
						}
					}
					if (ai == 8) {
						done = true;
					}
				}
				*/
			}
			
			var h2:Harbor;
			for each(h in World.harbors){
				x = Math.floor(h.x / 100);
				y = Math.floor(h.y / 100);
				heightMap.setPixel(x, y, 0xFFFFFF);
				for (var i:int = 0; i < Math.floor(Math.random() * 5) + 1; i++){
					h2 = World.harbors[Math.floor(Math.random() * World.harbors.length)];
					if (h != h2){
						if (Math.random() > 0.9){
							h.connections.push(new Connection(h, h2, "plane", 50*(new Point(h.x - x - dx, h.y - y - dy)).length, Math.floor(Math.random() * 24 * 7), (Math.floor(Math.random() * 7)+6) * 24));
						}else{
							h.connections.push(new Connection(h, h2, "boat", 10*(new Point(h.x - x - dx, h.y - y - dy)).length, Math.floor(Math.random() * 24 * 7), (Math.floor(Math.random() * 7)+6) * 24));
						}
					}
				}
			}
			trace( "connectionsMade:" + connectionsMade);
			
		}
		
	}

}