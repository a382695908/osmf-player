/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */
package com.robotmeals.video.singleplayer.controller.events
{
	import flash.events.Event;

	public class MediaWindowEvent extends Event
	{
		public static const MAIN_WINDOW_PLAY_STATE_CHANGE:String = "mainWindowPlayStateChange";
		public static const MAIN_WINDOW_CLICKED:String = "mainWindowClicked";
		public static const MAIN_WINDOW_ROLL_OUT:String = "mainWindowRollOut";
		public static const MAIN_WINDOW_ROLL_OVER:String = "mainWindowRollOver";
		public static const MAIN_WINDOW_CURRENT_TIME_CHANGE:String = "mainWindowCurrentTimeChange";
		public static const MAIN_WINDOW_DURATION_CHANGE:String = "mainWindowDurationChange";
		public static const MAIN_WINDOW_BYTES_LOADED_CHANGE:String = "mainWindowBytesLoadedChange";
		public static const MAIN_WINDOW_BYTES_TOTAL_CHANGE:String = "mainWindowBytesTotalChange";
		public static const MAIN_WINDOW_LOAD_COMPLETE:String = "mainWindowLoadComplete";
		public static const MAIN_WINDOW_MEDIA_ERROR:String = "mainWindowMediaError";
		public static const DEFAULT:String = "mainWindowDefaultEvent";

		public var time:Number;
		public var bytes:Number;
		public var errorType:String;
		public var playState:String;

		public function MediaWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new MediaWindowEvent(type);
		}
	}
}

