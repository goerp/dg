package nl.goerp.dive.screens 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.AVLoadInfoEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Goerp
	 */
	public class DiveScreen extends Sprite 
	{
		
		public function DiveScreen() 
		{
			super();
			var b:Bitmap = new Bitmap(new BitmapData(800, 600, true, 0x44556678));
			addChild(b);
			addEventListener(MouseEvent.CLICK, clicked);
		}
		
		public function clicked(me:MouseEvent):void{
			init(me.localX, me.localY);
		}
		
		public function init(xi:Number, yi:Number):void{

			var s:Array=new Array;
			var period:Array=new Array; 
			var amplitude:Array=new Array;

			
			//make s0 x and s1 y
			s[0] = xi; //Math.floor(Math.random() * Math.pow(2, 32));
			s[1] = yi; //Math.floor(Math.random() * Math.pow(2, 32));
			
			var x2:int = s[0];
			var y2:int = s[1];
			var y:Number;

			var startDepth:int = 150 + Math.min(xi + yi, 127) + ((xi ^ (yi >> 7)) & 63);
			var endDepth:int = 50 + Math.min(xi + yi, 127) + ((xi ^ (yi >> 7)) & 63);
			var waterLevel:int = 200;
			var rockyness:int = Math.pow(2,(Math.ceil((xi^yi) & 7)+1))-1;
			
			//trace(depth);
			for (var i:int = 0; i < 10; i++){
				x2 = s[0];
				y2 = s[1];
				s[0] = y2;
				x2 ^= x2 << 23
				s[1] = x2 ^ y2 ^ y2 ^ (x2 >> 17) ^ (y2 >> 26);
				period.push((((s[1] + y2) & 31) >> 1)+3);	
				//trace(period[i]);
			}
			for (i= 0; i < 10; i++){
				x2 = s[0];
				y2 = s[1];
				s[0] = y2;
				x2 ^= x2 << 23
				s[1] = x2 ^ y2 ^ y2 ^ (x2 >> 17) ^ (y2 >> 26);
				amplitude.push(((s[1] + y2) & rockyness) >> 1);	
				//trace(amplitude[i]);
			}
			
			graphics.clear();
			
			graphics.beginFill(0x6644ff);
			graphics.drawRect(0, waterLevel, 800, 600 - waterLevel);
			graphics.endFill
			
			
			graphics.beginFill(0xff00ff);
			graphics.lineStyle(2, 0x38530F);// beginFill(0xff00ff);
			
			var yold:Number = 300;
			graphics.moveTo(0, 600);
			graphics.lineTo(0, 300);
			for ( var x:int = 1; x < 800; x+=10){			
				y = startDepth+((startDepth-endDepth)*(x/800));
				for ( i = 0; i < 10; i++){
					y = y + Math.sin((x / 3) / period[i]) * amplitude[i];
					if (isNaN(y)){
						trace("debug here");
					}
				}
				//graphics.drawCircle(x, y, 1);
				graphics.lineTo(x, y);
				
			}
			graphics.lineTo(800, 600);
			graphics.lineTo(0, 600);
			graphics.endFill();
			
			
			
		}
		
	}
/*			
 			var y:Number;
			var period:Array; 
			var amplitude:Array; = [12, 33, 57, 11, 21, -7, -23, 3, -31, -17];
			graphics.beginFill(0xff00ff);
for ( var x:int = 0; x < 800; x++){
				y = 300;
				for ( var i:int = 0; i < 10; i++){
					y = y + Math.sin(x / period[i]) * amplitude[i];
				}
				graphics.drawCircle(x, y, 1);
				
			}
*/
}