package {
	
	import flash.geom.Point;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.MovieClip;
	
	public class AnimationEvent
	{
		public var clip:MovieClip;
		public var animType:String;
		public var when:Number;
		public var speed:Number;
		public var easing;
		public var tween1:Tween;
		public var tween2:Tween;
		public var targetPoint:Point;
		public var targetValue:Number;
		//public AnimationEvent()
	}

}