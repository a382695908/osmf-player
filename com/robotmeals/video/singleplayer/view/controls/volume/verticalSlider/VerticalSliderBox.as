/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.volume.verticalSlider
{
	import com.robotmeals.video.singleplayer.controller.events.ControlEvent;
	import com.robotmeals.video.singleplayer.utils.HitAreaUtil;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class VerticalSliderBox extends MovieClip
	{
		private var _volume:Number;

		//already on stage
		public var handle:VerticalSliderHandle;

		public var track:VerticalSliderTrack;

		public function VerticalSliderBox()
		{
			//initial setup
			track.buttonMode = true;
			handle.buttonMode = true;

			//create hit area for track since only 1px wide
			var hitArea:HitAreaUtil = new HitAreaUtil();
			hitArea.createHitArea(track, handle.width, track.height, 0, 0);

			//add event listener to the track and handle
			track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
			handle.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
		}

		private function onTrackDown(e:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, moveHandle);
		}

		private function moveHandle(e:Event):void
		{
			//move the handle to the mouse y position
			handle.y = this.mouseY;

			//set y limits for level
			var yMax:Number = track.y + track.height;
			var yMin:Number = track.y;

			//keep handle from being higher than yMax
			if (handle.y >= yMax)
			{
				handle.y = yMax - 1;
			}

			//keep handle from being lower than yMin
			if (handle.y <= yMin)
			{
				handle.y = yMin;
			}

			//set the new volume according to handle position
			_volume = int(((track.height - handle.y) / track.height) * 10) / 10;

			//dispatch new volume change event with newVolume as the payload
			var ve:ControlEvent = new ControlEvent(ControlEvent.VOLUME_CHANGED);
			ve.volume = _volume;
			dispatchEvent(ve);
		}

		public function stopHandle():void
		{
			//remove drag listener
			this.removeEventListener(Event.ENTER_FRAME, moveHandle);
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		GETTERS AND SETTERS									//
		//															//
		//////////////////////////////////////////////////////////////

		public function get volume():Number
		{
			return _volume;
		}

		public function set volume(value:Number):void
		{
			_volume = value;

			//set handle y location according to initial volume
			handle.y = int(track.height - (_volume * track.height));
		}
	}
}

