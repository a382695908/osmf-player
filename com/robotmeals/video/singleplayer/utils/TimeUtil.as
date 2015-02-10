/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */
package com.robotmeals.video.singleplayer.utils
{

	public class TimeUtil
	{
		public function convertSecondsToMinsSec(seconds:int):String
		{
			var timeOut:String;
			var mins:int = int(seconds / 60);
			var secs:int = seconds % 60;

			if (isNaN(mins) || isNaN(secs))
			{
				return "--:--";
			}

			var minS:String = (mins < 10) ? "0" + mins : String(mins);
			var secS:String = (secs < 10) ? "0" + secs : String(secs);

			timeOut = minS + ":" + secS;
			return timeOut;
		}

	}
}

