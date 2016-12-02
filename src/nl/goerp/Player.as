package nl.goerp 
{
	import com.bit101.components.NumericStepper;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Goerp
	 */
	public class Player 
	{
		public var money:Number=0;
		public var health:Number=0;
		public var energy:Number=0;
		public var breath:Number=0;

		public var no2:Number=0;
		public var o2InBreath:Number=0;
		
		public var visual:Sprite = new Sprite;
		public const beltWeight:Number = 0;
		
		public var flippers:Boolean = false;
		
		
		public var MIN_O2_NEEDED:Number = 0.1;
		
		public var O2_USE_IN_REST:Number = 0.004;
		public var O2_USE_PER_KICK:Number = 0.05;
		
		public const MAX_BREATH:uint = 40;
		public const BASE_WEIGHT:Number = 80;
		public const BASE_DOWN_FORCE:Number = 9.8 * BASE_WEIGHT;	
		public const UP_FORCE_WITH_AIR:Number = 9.8 * (1020 * BASE_WEIGHT / 985);	
		public const UP_FORCE_WITHOUT_AIR:Number = 9.8 * (1020 * BASE_WEIGHT/ 945);	
		public const POWER_WITH_FLIPPER:Number = 600;
		public const POWER_WITHOUT_FLIPPER:Number = 300;
		
		public function upForce():Number {
			return 10 * (1020 * BASE_WEIGHT / (945 + breath));
		}
		public function takeBreath():void{
			breath = MAX_BREATH;
			o2InBreath = 1;
		}
		public function breatheOut():void{
			breath = 0;
		}
		
		public function updateO2():void{
			o2InBreath -= O2_USE_IN_REST;
			if (o2InBreath < 0) o2InBreath = 0;
			if (o2InBreath < 0.1){
				trace("suffocating");
			}
		}
		
		public function moveLeg():void{
			var maxPower:Number = flippers?POWER_WITH_FLIPPER:POWER_WITHOUT_FLIPPER;
			o2InBreath -= O2_USE_PER_KICK
			if (o2InBreath < 0) o2InBreath = 0;
			if (o2InBreath < MIN_O2_NEEDED) {
				maxPower = maxPower * o2InBreath/MIN_O2_NEEDED;
			}
			fy = Math.sin(visual.rotation * 6.28 / 360) * maxPower;
			fx = Math.cos(visual.rotation * 6.28 / 360) * maxPower;
		}
		
		
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var fx:Number = 0;
		public var fy:Number = 0;
		
		public function Player() 
		{
			visual.graphics.lineStyle(2, 0);
			visual.graphics.moveTo( 25, -5);
			visual.graphics.lineTo(30, 0);
			visual.graphics.lineTo( 25, 5);
			visual.graphics.moveTo(30, 0);
			visual.graphics.lineTo( 0,0);
			
		}
		
		//The average density of the human body is 985 kg/m3, and the typical density of seawater is about 1020 kg/m3.
		//	The average density of the human body, after maximum inhalation of air, changes to 945 kg/m3. 
		//	As a person floating in seawater inhales and exhales slowly, what percentage of his volume moves up out of and down into the water?
		
		
		
		
	}

}