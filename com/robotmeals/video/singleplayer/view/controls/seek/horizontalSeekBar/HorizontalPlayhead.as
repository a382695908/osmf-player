/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.seek.horizontalSeekBar
{
	import flash.display.MovieClip;

	public class HorizontalPlayhead extends MovieClip
	{
		private var _position:Number;

		public function set position(value:Number):void
		{
			_position = value;
			this.x = _position;
		}

		public function get position():Number
		{
			return _position;
		}
	}
}

