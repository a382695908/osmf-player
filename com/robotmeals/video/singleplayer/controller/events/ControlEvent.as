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

	public class ControlEvent extends Event

	{
		public static const PLAY_PAUSE_PRESSED:String = "playPausePressed";

		public static const SEEKBAR_CHANGED:String = "seekBarChanged"

		public static const FULLSCREEN_PRESSED:String = "fullScreenPressed";

		public static const VOLUME_CHANGED:String = "volumeChanged";

		public static const SEEK_CHANGE_START:String = "seekChangeStart";

		public static const SEEK_CHANGE_END:String = "seekChangeEnd";

		public static const DEFAULT:String = "controlEventDefault";

		public var volume:Number;

		public var time:Number;

		public var errorType:String;

		public function ControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ControlEvent(type);
		}
	}
}

