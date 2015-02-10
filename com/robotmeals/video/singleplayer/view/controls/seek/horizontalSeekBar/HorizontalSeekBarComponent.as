/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.seek.horizontalSeekBar
{
	import com.robotmeals.video.singleplayer.controller.events.ControlEvent;
	import com.robotmeals.video.singleplayer.utils.HitAreaUtil;
	import com.robotmeals.video.singleplayer.view.controls.seek.ISeekComponent;
	import com.robotmeals.video.singleplayer.view.controls.timeDisplay.text.SimpleTimeDisplay;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class HorizontalSeekBarComponent extends MovieClip implements ISeekComponent
	{
		private var _size:Number;

		private var _bytesLoaded:Number;

		private var _duration:Number;

		private var _currentTime:Number;

		private var _ce:ControlEvent;

		//already on stage
		public var playHead:HorizontalPlayhead;

		public var progressBar:HorizontalProgressBar;

		public var timeDisplay:SimpleTimeDisplay;

		public var track:HorizontalSeekBarTrack;

		public function HorizontalSeekBarComponent()
		{
			//set initial values
			_size = 0;
			_bytesLoaded = 0;
			_duration = 0;
			_currentTime = 0;

			//create the hit area for the track and playhead
			var hitArea:HitAreaUtil = new HitAreaUtil();
			hitArea.createHitArea(track, track.width, track.height / 2, 0, track.height / 4);

			//set button mode for track and progress bar
			track.buttonMode = true;
			progressBar.buttonMode = true;

			//add event listeners
			track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
			progressBar.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
			track.addEventListener(MouseEvent.MOUSE_UP, onTrackUp);
			progressBar.addEventListener(MouseEvent.MOUSE_DOWN, onTrackUp);
		}


		//////////////////////////////////////////////////////////////
		//															//
		// 		MOUSE EVENT HANDLERS								//
		//															//
		//////////////////////////////////////////////////////////////

		private function onTrackDown(e:MouseEvent):void
		{
			//Send event to pause media window
			_ce = new ControlEvent(ControlEvent.SEEK_CHANGE_START);
			dispatchEvent(_ce);

			//start moving the playhead
			addEventListener(Event.ENTER_FRAME, movePlayhead);
		}

		private function onTrackUp(e:MouseEvent):void
		{
			//Send event to pause media window
			_ce = new ControlEvent(ControlEvent.SEEK_CHANGE_END);
			dispatchEvent(_ce);

			//stop moving the playhead
			removeEventListener(Event.ENTER_FRAME, movePlayhead);
		}

		private function movePlayhead(e:Event):void
		{	

			//move the playHead to the mouse y position
			playHead.position = this.mouseX;

			//set x limits for playHead
			var xMax:Number = track.x + track.width;
			var xMin:Number = track.x;

			//keep playHead from being higher than yMax
			if (playHead.position >= xMax)
			{
				playHead.position = xMax - 1;
			}

			//keep playHead from being lower than yMin
			if (playHead.position <= xMin)
			{
				playHead.position = xMin;
			}

			//set the new time according to playHead position

			//FIXME: finish getting seek bar time working correctly
			var perc:Number = playHead.position / track.width;
			var newTime:Number = perc * duration;

			//dispatch new volume change event with newVolume as the payload
			_ce = new ControlEvent(ControlEvent.SEEKBAR_CHANGED);
			_ce.time = newTime;
			trace(_ce.time);
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
		}

		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}

		public function set bytesLoaded(value:Number):void
		{
			_bytesLoaded = value;

			//scale the length of the progress bar according to bytes loaded / size
			progressBar.scaleX = _bytesLoaded / _size;
		}

		public function get duration():Number
		{
			return _duration;
		}

		public function set duration(value:Number):void
		{
			_duration = value;

			//send the duration time to the time display
			timeDisplay.duration = _duration;
		}

		public function get currentTime():Number
		{
			return _currentTime;
		}

		public function set currentTime(value:Number):void
		{
			_currentTime = value;

			//send the current time to the time display
			timeDisplay.currentTime = _currentTime;

			//set the playhead position
			playHead.position = int((_currentTime / _duration) * track.width) + track.x;

		}
	}
}

