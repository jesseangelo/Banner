<<<<<<< HEAD
﻿import AnimationEvent;
import flash.geom.Point;
import mx.transitions.Tween;
import mx.transitions.easing.*;


/*****************************************
 *
 *	Scheduler
 *	Runs a queue of animations
 *	Author: Jesse Angelo
 *	Version: 0.02
 *	Date: 19-Jul-2012
 *
 ***/
class Scheduler 
{
	private var taskQueue:Array;
	private var currentTime:Number;
	private var myTimer = null;
	private var cTime = 0;
	public static var SPEED_QUICKEST:Number		= 0.2;
	public static var SPEED_QUICKER	:Number		= 0.4;
	public static var SPEED_QUICK	:Number		= 0.6;
	public static var SPEED_SNAPPY	:Number		= 0.8;
	public static var SPEED_NORMAL	:Number 	= 1.0;
	public static var SPEED_SLOW	:Number		= 1.2;
		
	
	//Constructor
	public function Scheduler()
	{
		//Eventually this should be static, AS2 is a pain
		//throw("ERROR: 'Scheduler' is static. Don't make instances!");
		
		currentTime = 0;
		taskQueue = new Array();
		myTimer = setInterval(this, "update", 1000/24);
		
	}
	
	
	private function update()
	{
		//trace("updating");		
		if(taskQueue.length)
		{
			for(var n = 0; n < taskQueue.length; n++)
			{
				var myTask = taskQueue[n];
				
				//When task is ready to go, create the tweens
				if(myTask.when == currentTime)
				{
					switch(myTask.animType)
					{
						case "fadeIn":
							myTask.tween1 = new Tween(myTask.clip, "_alpha", myTask.easing, 0, 100, myTask.speed, true);
							break;
							
						case "fadeOut":
							myTask.tween1 = new Tween(myTask.clip, "_alpha", myTask.easing, myTask.clip._alpha, 0, myTask.speed, true);
							break;
							
						case "scale":
							myTask.tween1 = new Tween(myTask.clip, "_xscale", myTask.easing, myTask.clip._xscale, myTask.targetValue, myTask.speed, true);
							myTask.tween2 = new Tween(myTask.clip, "_yscale", myTask.easing, myTask.clip._yscale, myTask.targetValue, myTask.speed, true);
							break;
							
						case "move":
							myTask.tween1 = new Tween(myTask.clip, "_x", myTask.easing, myTask.clip._x, myTask.targetPoint.x, myTask.speed, true);
							myTask.tween2 = new Tween(myTask.clip, "_y", myTask.easing, myTask.clip._y, myTask.targetPoint.y, myTask.speed, true);
							break;
						
						//On complete, clean up
					}
				}
			}
		
		currentTime++;
		
		}
	}
	
	
	
	/*********************************
	*	Get a time to run the animation
	*	after the previous animation's time
	**/
	private function getFutureTime(msToAdd:Number):Number
	{
		if(taskQueue.length)
			return taskQueue[taskQueue.length-1].when + msToAdd;
		else
			return msToAdd;
	}
	
	
	/*********************************
	*	Fade the clip in from alpha 0
	**/
	public function fadeIn(clip:MovieClip, when:Number, speed:Number, easing)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(speed == undefined) speed = SPEED_NORMAL;
		if(easing == undefined) easing = None.easeNone;
		if(clip == null || clip == undefined)
			throw("WARNING: You are trying to FadeIn an undefined movieClip");
		
		myEvt.clip = clip;
		myEvt.animType = "fadeIn";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetValue = 100;
		//myEvt.tween1 = new Tween(clip, "_alpha", easing, 0, 100, speed, true);
		//myEvt.tween1.stop();
		taskQueue.push(myEvt);
	}
	
	
	/************************************
	*	Fade the clip out from alpha 100
	*/
	public function fadeOut(clip:MovieClip, when:Number, speed:Number, easing)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(speed == undefined) speed = SPEED_NORMAL;
		if(easing == undefined) easing = None.easeNone;
		if(clip == null || clip == undefined)
			throw("WARNING: You are trying to FadeOut an undefined movieClip");
			
		myEvt.clip = clip;
		myEvt.animType = "fadeOut";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetValue = 0;
		//myEvt.tween1 = new Tween(clip, "_alpha", easing, 0, 100, speed, true);
		//myEvt.tween1.stop();
		taskQueue.push(myEvt);
	}
	
	
	/************************************************
	*	Scale the clip from current scale to scaleTo
	*/
	public function scale(clip:MovieClip, when:Number, scaleTo:Number, speed:Number, easing)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(speed == undefined) speed = SPEED_NORMAL;
		if(easing == undefined) easing = None.easeNone;
		if(clip == null || clip == undefined)
			throw("WARNING: You are trying to Scale an undefined movieClip");
		
		var startScale = clip._xscale;
		
		myEvt.clip = clip;
		myEvt.animType = "scale";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetValue = scaleTo;
		//myEvt.tween1 = new Tween(clip, "_alpha", easing, 0, 100, speed, true);
		//myEvt.tween1.stop();
		
		taskQueue.push(myEvt);
		
	}
	

	/*****************************************
	*	Tranlate the clip to a point location
	**/
	public function move(clip:MovieClip, when:Number, to:Point, speed, easing)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(speed == undefined) speed = SPEED_NORMAL;
		if(easing == undefined) easing = None.easeNone;
		if(clip == null || clip == undefined)
			throw("WARNING: You are trying to Move an undefined movieClip");
		//trace("easing: " + easing);
		//trace("moving: \"" + clip._name + "\" to: " + to);
		
		myEvt.clip = clip;
		myEvt.animType = "move";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetPoint = to;
		
		taskQueue.push(myEvt);
		
	}
}
=======
﻿package {
	import AnimationEvent;
	import flash.geom.Point;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	
/*****************************************
 *
 *	Scheduler
 *	Runs a queue of animations
 *	Author: Jesse Angelo
 *	Version: 0.02
 *	Date: 19-Jul-2012
 *
 ***/
public class Scheduler 
{
	private var taskQueue:Array;
	private var currentTime:Number;
	private var myTimer:Timer;
	private var cTime = 0;
	public static const SPEED_QUICKEST	:Number		= 0.2;
	public static const SPEED_QUICKER	:Number		= 0.4;
	public static const SPEED_QUICK		:Number		= 0.6;
	public static const SPEED_SNAPPY	:Number		= 0.8;
	public static const SPEED_NORMAL	:Number 	= 1.0;
	public static const SPEED_SLOW		:Number		= 1.2;
		
	
	//Constructor
	public function Scheduler()
	{
		//Eventually this should be static, AS2 is a pain
		//throw("ERROR: 'Scheduler' is static. Don't make instances!");
		
		currentTime = 0;
		taskQueue = new Array();
		//myTimer = setInterval(this, "update", 1000/24);
		myTimer = new Timer(1000/24);
		myTimer.start();
		myTimer.addEventListener(TimerEvent.TIMER, update);
		
	}
	
	
	private function update(t:TimerEvent):void
	{
		trace("updating");		
		if(taskQueue.length)
		{
			for(var n = 0; n < taskQueue.length; n++)
			{
				var myTask = taskQueue[n];
				
				//When task is ready to go, create the tweens
				if(myTask.when == currentTime)
				{
					switch(myTask.animType)
					{
						case "fadeIn":
							myTask.tween1 = new Tween(myTask.clip, "alpha", myTask.easing, 0, 100, myTask.speed, true);
							break;
							
						case "fadeOut":
							myTask.tween1 = new Tween(myTask.clip, "alpha", myTask.easing, myTask.clip.alpha, 0, myTask.speed, true);
							break;
							
						case "scale":
							myTask.tween1 = new Tween(myTask.clip, "scaleX", myTask.easing, myTask.clip.scaleX, myTask.targetValue, myTask.speed, true);
							myTask.tween2 = new Tween(myTask.clip, "scaleY", myTask.easing, myTask.clip.scaleY, myTask.targetValue, myTask.speed, true);
							break;
							
						case "move":
							myTask.tween1 = new Tween(myTask.clip, "x", myTask.easing, myTask.clip.x, myTask.targetPoint.x, myTask.speed, true);
							myTask.tween2 = new Tween(myTask.clip, "y", myTask.easing, myTask.clip.y, myTask.targetPoint.y, myTask.speed, true);
							break;
						
						//On complete, clean up
					}
				}
			}
		
		currentTime++;
		
		}
	}
	
	
	
	/*********************************
	*	Get a time to run the animation
	*	after the previous animation's time
	**/
	private function getFutureTime(msToAdd:Number):Number
	{
		if(taskQueue.length)
			return taskQueue[taskQueue.length-1].when + msToAdd;
		else
			return msToAdd;
	}
	
	
	/*********************************
	*	Fade the clip in from alpha 0
	**/
	public function fadeIn(clip:MovieClip, when:Number=0, speed:Number=SPEED_NORMAL, easing=undefined)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(easing == undefined) easing = None.easeNone;
		if(clip == null)
			throw("WARNING: You are trying to FadeIn an undefined movieClip");
		
		myEvt.clip = clip;
		myEvt.animType = "fadeIn";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetValue = 100;
		//myEvt.tween1 = new Tween(clip, "_alpha", easing, 0, 100, speed, true);
		//myEvt.tween1.stop();
		taskQueue.push(myEvt);
	}
	
	
	/************************************
	*	Fade the clip out from alpha 100
	*/
	public function fadeOut(clip:MovieClip, when:Number=0, speed:Number=SPEED_NORMAL, easing=undefined)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(easing == undefined) easing = None.easeNone;
		if(clip == null)
			throw("WARNING: You are trying to FadeOut an undefined movieClip");
			
		myEvt.clip = clip;
		myEvt.animType = "fadeOut";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetValue = 0;
		//myEvt.tween1 = new Tween(clip, "_alpha", easing, 0, 100, speed, true);
		//myEvt.tween1.stop();
		taskQueue.push(myEvt);
	}
	
	
	/************************************************
	*	Scale the clip from current scale to scaleTo
	*/
	public function scale(clip:MovieClip, scaleTo:Number, when:Number=0, speed:Number=SPEED_NORMAL, easing=undefined)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(easing == undefined) easing = None.easeNone;
		if(clip == null)
			throw("WARNING: You are trying to Scale an undefined movieClip");
		
		var startScale = clip.scaleX;
		
		myEvt.clip = clip;
		myEvt.animType = "scale";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetValue = scaleTo;
		//myEvt.tween1 = new Tween(clip, "_alpha", easing, 0, 100, speed, true);
		//myEvt.tween1.stop();
		
		taskQueue.push(myEvt);
		
	}
	

	/*****************************************
	*	Tranlate the clip to a point location
	**/
	public function move(clip:MovieClip, to:Point, when:Number=0, speed:Number=SPEED_NORMAL, easing=undefined)
	{
		var myEvt:AnimationEvent = new AnimationEvent();
		if(easing == undefined) easing = None.easeNone;
		if(clip == null)
			throw("WARNING: You are trying to Move an undefined movieClip");
		//trace("easing: " + easing);
		//trace("moving: \"" + clip._name + "\" to: " + to);
		
		myEvt.clip = clip;
		myEvt.animType = "move";
		myEvt.when = getFutureTime(when);
		myEvt.speed = speed;
		myEvt.easing = easing;
		myEvt.targetPoint = to;
		
		taskQueue.push(myEvt);
		
	}
}
}
>>>>>>> Updated to AS3
