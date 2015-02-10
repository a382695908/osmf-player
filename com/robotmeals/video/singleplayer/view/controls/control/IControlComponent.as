/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.control
{

	public interface IControlComponent
	{
		function set volume (value:Number):void
		function get volume ():Number
		function set currentTime(value:Number):void
		function get currentTime():Number
		function set duration(value:Number):void
		function get duration():Number
		function set size(value:Number):void
		function get size():Number
	}
}

