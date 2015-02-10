/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.control.horizontalControlBar
{
	import com.robotmeals.video.singleplayer.controller.events.ControlEvent;
	import com.robotmeals.video.singleplayer.view.controls.buttons.regularButton.RegularButton;
	import com.robotmeals.video.singleplayer.view.controls.buttons.toggleButton.ToggleButton;
	import com.robotmeals.video.singleplayer.view.controls.control.IControlComponent;
	import com.robotmeals.video.singleplayer.view.controls.seek.horizontalSeekBar.HorizontalPlayhead;
	import com.robotmeals.video.singleplayer.view.controls.seek.horizontalSeekBar.HorizontalProgressBar;
	import com.robotmeals.video.singleplayer.view.controls.seek.horizontalSeekBar.HorizontalSeekBarComponent;
	import com.robotmeals.video.singleplayer.view.controls.volume.verticalSlider.VerticalSliderComponent;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class HorizontalControlBarComponent extends MovieClip implements IControlComponent
	{
		private var _size:Number;

		private var _bytesLoaded:Number;

		private var _duration:Number;

		private var _currentTime:Number;

		private var _ce:ControlEvent;

		private var _volume:Number;

		//already on stage in controlBar
		public var playPauseButton:ToggleButton;

		public var volumeSlider:VerticalSliderComponent;

		public var seekBar:HorizontalSeekBarComponent;

		public var fullScreenButton:RegularButton;

		public function HorizontalControlBarComponent()
		{
			//set values
			_size = 0;
			_bytesLoaded = 0;
			_duration = 0;
			_currentTime = 0;

			//add event listeners for components
			playPauseButton.addEventListener(MouseEvent.CLICK, onMouseEvent);
			volumeSlider.slideBox.addEventListener(ControlEvent.VOLUME_CHANGED, onControlEvent);
			fullScreenButton.addEventListener(MouseEvent.CLICK, onMouseEvent);
			seekBar.addEventListener(ControlEvent.SEEK_CHANGE_END, onControlEvent);
			seekBar.addEventListener(ControlEvent.SEEK_CHANGE_START, onControlEvent);
			seekBar.addEventListener(ControlEvent.SEEKBAR_CHANGED, onControlEvent);
		}


		//////////////////////////////////////////////////////////////
		//															//
		// 		SEEK EVENT HANDLERS									//
		//															//
		//////////////////////////////////////////////////////////////

		private function onControlEvent(e:ControlEvent):void
		{
			switch(e.type)
			{
				case "volumeChanged":
					_ce = new ControlEvent(ControlEvent.VOLUME_CHANGED);
					_ce.volume = e.volume;
					break;

				case "seekChangeEnd":
					_ce = new ControlEvent(ControlEvent.SEEK_CHANGE_END);
					break;

				case "seekChangeStart":
					_ce = new ControlEvent(ControlEvent.SEEK_CHANGE_START);
					break;

				case "seekBarChanged":
					_ce = new ControlEvent(ControlEvent.SEEKBAR_CHANGED);
					_ce.time = e.time;
					break;

				default:
					//dispatch default error event if no case is matched
					_ce = new ControlEvent(ControlEvent.DEFAULT);
					_ce.errorType = "control mediator onControlEvent default case error: " + e.type;
					break;
			}
			dispatchEvent(_ce);
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		MOUSE EVENT HANDLERS								//
		//															//
		//////////////////////////////////////////////////////////////

		private function onMouseEvent(e:MouseEvent):void
		{

			switch (e.target)
			{
				case fullScreenButton:
					_ce = new ControlEvent(ControlEvent.FULLSCREEN_PRESSED);
					break;

				case playPauseButton:
					_ce = new ControlEvent(ControlEvent.PLAY_PAUSE_PRESSED);
					break;

				default:
					_ce = new ControlEvent(ControlEvent.DEFAULT);
					break;
			}
			dispatchEvent(_ce);
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		GETTERS AND SETTERS									//
		//															//
		//////////////////////////////////////////////////////////////

		public function get size():Number
		{
			return _size;
		}

		public function set size(value:Number):void
		{
			_size = value;

			//send the size to the seekbar
			seekBar.size = _size;
		}

		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}

		public function set bytesLoaded(value:Number):void
		{
			_bytesLoaded = value;

			//send the size to the seekbar
			seekBar.bytesLoaded = _bytesLoaded;
		}

		public function get duration():Number
		{
			return _duration;
		}

		public function set duration(value:Number):void
		{
			_duration = value;

			//send the duration to the seekbar
			seekBar.duration = _duration;
		}

		public function get currentTime():Number
		{
			return _currentTime;
		}

		public function set currentTime(value:Number):void
		{
			_currentTime = value;

			//send the current time to the seekbar
			seekBar.currentTime = _currentTime;
		}

		public function get volume():Number
		{
			return _volume;
		}

		public function set volume(value:Number):void
		{
			_volume = value;
			//update the volume slider
			volumeSlider.volume = _volume;
		}
	}
}

