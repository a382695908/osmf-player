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
	import com.robotmeals.video.singleplayer.view.controls.volume.IVolumeComponent;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class VerticalSliderComponent extends MovieClip implements IVolumeComponent
	{
		private var _volume:Number;

		//already on stage
		public var slideBox:VerticalSliderBox;

		public var volumeSymbol:VerticalSliderVolumeButton;

		public function VerticalSliderComponent()
		{
			//initial setup
			slideBox.visible = false;

			//button modes
			volumeSymbol.buttonMode = true;

			//add event listeners to entire component to toggle views
			volumeSymbol.addEventListener(MouseEvent.CLICK, onSymbolClick);

			//add mouse event listeners
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}

		private function onSymbolClick(e:MouseEvent):void
		{
			//toggle view
			volumeSymbol.visible = false;
			slideBox.visible = true;
			volumeSymbol.buttonMode = false;
		}

		private function onMouseUp(e:MouseEvent):void
		{
			//toggle view
			volumeSymbol.visible = true;
			slideBox.visible = false;
			volumeSymbol.buttonMode = true;
			slideBox.stopHandle();
		}

		private function onRollOut(e:MouseEvent):void
		{
			//toggle view
			volumeSymbol.visible = true;
			slideBox.visible = false;
		}

		//TODO: function for visual tween transition between states

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

			//send the volume to the slideBox
			slideBox.volume = _volume;
		}
	}
}

