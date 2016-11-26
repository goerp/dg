package nl.goerp.dive
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import nl.goerp.Option;
	import nl.goerp.dive.screens.DiveScreen;
	import nl.goerp.dive.screens.StartScreen;
	import nl.goerp.dive.screens.StrategyScreen;
	
	/**
	 * ...
	 * @author Goerp
	 */
	public class Main extends Sprite 
	{
		
		private var divingProtoButton:PushButton = new PushButton(null, 200, 200, "diving");
		private var strategyProtoButton:PushButton = new PushButton(null, 400, 200, "strategy");
		private var strategyScreen:StrategyScreen = new StrategyScreen;
		private var divingScreen:DiveScreen = new DiveScreen;
		private var startScreen:StartScreen = new StartScreen;
		
		private var currentharbor:int = 0;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			World.map.buildHeightMap();
		}
		
		private function init(e:Event = null):void 
		{
			divingProtoButton.addEventListener(MouseEvent.CLICK, startDivingProto);
			strategyProtoButton.addEventListener(MouseEvent.CLICK, startStrategyProto);
			startScreen.addChild(divingProtoButton);
			startScreen.addChild(strategyProtoButton);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			setScreen(startScreen);
		}
		private function startDivingProto(e:Event):void{
			divingScreen.addChild(new Label(divingScreen, 300, 300, "diving"));
			//divingScreen.init();
			setScreen(divingScreen);
		}
		private function startStrategyProto(e:Event):void{
			strategyScreen.addChild(new Label(strategyScreen, 300, 300, "strategy"));
			strategyScreen.addChild(new Bitmap(World.map.heightMap));
			strategyScreen.scaleX = 5;
			strategyScreen.scaleY = 5;
			setScreen(strategyScreen);
			stage.addEventListener(KeyboardEvent.KEY_UP, doKeyUp);
		}
		private function doKeyUp(ke:KeyboardEvent):void{
			if (ke.keyCode == Keyboard.PAGE_UP){
				currentharbor++;
				if(currentharbor>=World.harbors.length) currentharbor=0;
			}
			if (ke.keyCode == Keyboard.PAGE_DOWN){
				currentharbor--;
				if (currentharbor < 0) currentharbor = World.harbors.length - 1;
			}
			strategyScreen.x =200-(5 * World.harbors[currentharbor].x/100);
			strategyScreen.y =200-(5 * World.harbors[currentharbor].y/100);
			
		}
		private function setScreen(screen:Sprite):void{
			if (numChildren>0) removeChild(this.getChildAt(0));
			addChild(screen);
		}
		
	}
	
}