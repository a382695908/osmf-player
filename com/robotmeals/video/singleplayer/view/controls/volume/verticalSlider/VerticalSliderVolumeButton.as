/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.volume.verticalSlider
{
	import flash.display.MovieClip;

	public class VerticalSliderVolumeButton extends MovieClip
	{

		private var _volume:Number;

		public function VerticalSliderVolumeButton()
		{
			super();
		}

		private function onSetVolume(value:Number):void
		{
			//TODO: change display state graphics of button according to volume
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		GETTERS AND SETTERS									//
		//															//
		//////////////////////////////////////////////////////////////

		public function set volume(value:Number):void
		{
			_volume = value;
			onSetVolume(_volume);
		}
	}
}

