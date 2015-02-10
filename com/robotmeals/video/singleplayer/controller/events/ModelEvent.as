/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.controller.events
{
	import com.robotmeals.video.singleplayer.model.vo.MediaVO;

	import flash.events.Event;

	public class ModelEvent extends Event
	{

		public static const MODEL_UPDATED:String = "modelUpdated";

		public static const MODEL_READY:String = "modelReady";

		public var mediaVO:MediaVO;

		//FUTURE: public var streams:Array;

		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ModelEvent(type);
		}
	}
}

