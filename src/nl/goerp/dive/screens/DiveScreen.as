package nl.goerp.dive.screens 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.AVLoadInfoEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Goerp
	 */
	public class DiveScreen extends Sprite 
	{
		public var diver:Sprite = World.player.visual;
		public var waterLevel:int = 200;
		
		public function DiveScreen() 
		{
			super();
			var b:Bitmap = new Bitmap(new BitmapData(800, 600, true, 0x44556678));
			addChild(b);
			addEventListener(MouseEvent.CLICK, clicked);
		}
		public function doTick(e:Event):void{
			
			World.player.updateO2();
			
			var weight:Number = World.player.BASE_WEIGHT + World.player.beltWeight;

			var fGravY:Number = World.player.BASE_DOWN_FORCE+(World.player.beltWeight * 9.8);
			var fBuoyY:Number ;
			if (World.player.visual.y < waterLevel ){
				World.player.takeBreath();
				if (World.player.visual.y + World.player.visual.height < waterLevel){
					fBuoyY = 0;
					
				}else{
					var partUnderWater:Number = World.player.visual.y + World.player.visual.height - waterLevel;
					partUnderWater = partUnderWater / World.player.visual.height;
					fBuoyY = -World.player.upForce() * partUnderWater;
				}
			}else{
				fBuoyY = -World.player.upForce();
			}
			
			//if (vDrag > v) vDrag = v;
			
			var fResultX:Number = World.player.fx;
			var fResultY:Number = World.player.fy + fGravY + fBuoyY;
			
			//https://en.wikipedia.org/wiki/Drag_(physics)#Drag_at_high_velocity
			/*var fFlipper:Number = v*(World.player.BASE_WEIGHT+World.player.beltWeight)-drag;
			var fy:Number;
			if (World.player.visual.y < waterLevel){
				fy = 0;
			}else {
				fy = fFlipper * Math.sin(World.player.visual.rotation * 6.28 / 360) + World.player.BASE_DOWN_FORCE+World.player.beltWeight * 9.8 - World.player.UP_FORCE_WITH_AIR;
			}
			var fx:Number = fFlipper * Math.cos(World.player.visual.rotation * 6.28 / 360);
			*/
			
			var dvx:Number = fResultX / weight;
			var dvy:Number = fResultY / weight;

			var v:Number = Math.sqrt((World.player.vx+dvx) * (World.player.vx+dvx) + (World.player.vy+dvy) * (World.player.vy+dvy));

			var fDrag:Number = -0.5 * 1020 * Math.pow(v, 2) * 0.04 * 0.5;
			var fDragx:Number = v != 0 ? fDrag * (World.player.vx / v) : 0;
			var fDragy:Number = v != 0 ? fDrag * (World.player.vy / v) : 0;
			
			fResultX = World.player.fx + fDragx;
			fResultY = World.player.fy + fGravY + fBuoyY + fDragy; 
			
			//trace("speed" + World.player.vy + " dv:"+ (fResultY / weight));
			

			World.player.vx += fResultX / weight;
			World.player.vy += fResultY / weight ;
			World.player.visual.x += World.player.vx ;
			World.player.visual.y += World.player.vy ;
			
			World.player.fx = 0;
			World.player.fy = 0;
			this.graphics.clear;
			this.graphics.beginFill(0x8888FF);
			this.graphics.drawRect(10, 10, (300 * World.player.o2InBreath), 10);
		}
		
		
		
		public function clicked(me:MouseEvent):void{
			init(me.localX, me.localY);
		}
		public function handleKey(ke:KeyboardEvent):void{
			if (ke.keyCode == Keyboard.LEFT) diver.rotation-=5;
			if (ke.keyCode == Keyboard.RIGHT) diver.rotation += 5;
			if (ke.keyCode == Keyboard.F) World.player.flippers != World.player.flippers;
			if (ke.keyCode == Keyboard.B) World.player.breatheOut();
			if (ke.keyCode == Keyboard.UP){
				World.player.moveLeg();
			}
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
			
			diver.y = waterLevel;
			diver.x = 300;
			addChild(diver);

			stage.addEventListener(KeyboardEvent.KEY_UP, handleKey);
			addEventListener(Event.ENTER_FRAME, doTick);

			
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