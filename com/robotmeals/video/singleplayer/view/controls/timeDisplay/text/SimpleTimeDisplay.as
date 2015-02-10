/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.timeDisplay.text
{
	import com.robotmeals.video.singleplayer.utils.TimeUtil;
	import com.robotmeals.video.singleplayer.view.controls.timeDisplay.ITimeDisplay;

	import flash.display.MovieClip;
	import flash.text.TextField;

	public class SimpleTimeDisplay extends MovieClip implements ITimeDisplay
	{
		private var _duration:Number;

		private var _currentTime:Number;

		private var _timeUtil:TimeUtil;

		//already  on stage
		public var currentTimeTextField:TextField;

		public var durationTextField:TextField;

		public function SimpleTimeDisplay()
		{
			//create a time helper object
			_timeUtil = new TimeUtil();

			//set up inital value for text fields
			currentTimeTextField.text = "--:--";
			durationTextField.text = "--:--";
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		GETTERS AND SETTERS									//
		//															//
		//////////////////////////////////////////////////////////////


		public function get duration():Number
		{
			return _duration;
		}

		public function set duration(value:Number):void
		{
			_duration = value;

			//set the human readable time display
			durationTextField.text = _timeUtil.convertSecondsToMinsSec(_duration);
		}
		public function get currentTime():Number
		{
			return _currentTime;
		}

		public function set currentTime(value:Number):void
		{
			_currentTime = value;

			//set the human readable time display
			currentTimeTextField.text = _timeUtil.convertSecondsToMinsSec(_currentTime);
		}
	}
}

