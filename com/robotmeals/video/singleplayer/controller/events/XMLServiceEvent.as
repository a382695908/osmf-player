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

	public class XMLServiceEvent extends Event
	{
		public static const XML_LOADED:String = "xmlLoaded";

		public static const XML_LOAD_FAIL:String = "xmlLoadFail";

		public var xml:XML;

		public function XMLServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new XMLServiceEvent(type);
		}
	}
}

