/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls
{
	import com.robotmeals.video.singleplayer.controller.events.ControlEvent;
	import com.robotmeals.video.singleplayer.controller.events.MediaWindowEvent;
	import com.robotmeals.video.singleplayer.controller.events.ModelEvent;
	import com.robotmeals.video.singleplayer.view.controls.control.horizontalControlBar.HorizontalControlBarComponent;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import org.osmf.events.LoadEvent;
	import org.osmf.events.TimeEvent;
	import org.robotlegs.mvcs.Mediator;

	public class ControlMediator extends Mediator
	{

		[Inject]
		public var view:HorizontalControlBarComponent;

		private var _ce:ControlEvent;

		override public function onRegister():void
		{
			//listen for model event
			eventMap.mapListener(eventDispatcher, ModelEvent.MODEL_READY, onModelReady);

			//listen for main media window events
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_CLICKED, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_ROLL_OVER, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_ROLL_OUT, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_CURRENT_TIME_CHANGE, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_DURATION_CHANGE, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_BYTES_LOADED_CHANGE, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_BYTES_TOTAL_CHANGE, onMainMediaWindowEvent);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_PLAY_STATE_CHANGE, onMainMediaWindowEvent);

			//listen for user interaction events from the control bar UI
			view.addEventListener(ControlEvent.FULLSCREEN_PRESSED, onControlEvent);
			view.addEventListener(ControlEvent.PLAY_PAUSE_PRESSED, onControlEvent);
			view.addEventListener(ControlEvent.SEEKBAR_CHANGED, onControlEvent);
			view.addEventListener(ControlEvent.SEEK_CHANGE_START, onControlEvent);
			view.addEventListener(ControlEvent.SEEK_CHANGE_END, onControlEvent);
			view.addEventListener(ControlEvent.VOLUME_CHANGED, onControlEvent);
			view.addEventListener(ControlEvent.DEFAULT, onControlEvent);
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		EVENT HANDLERS FOR MODEL EVENTS						//
		//															//
		//////////////////////////////////////////////////////////////

		private function onModelReady(e:ModelEvent):void
		{
			//trace("CONTROL MEDIATOR ON MODEL READY");

			//send the correct volume display to the control bar
			view.volume = e.mediaVO.volume;
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		EVENT HANDLERS FOR VIEW EVENTS						//
		//															//
		//////////////////////////////////////////////////////////////

		private function onControlEvent(e:ControlEvent):void
		{
			switch (e.type)
			{
				case "fullScreenPressed":
					_ce = new ControlEvent(ControlEvent.FULLSCREEN_PRESSED);
					break;

				case "playPausePressed":
					_ce = new ControlEvent(ControlEvent.PLAY_PAUSE_PRESSED);
					break;

				case "seekBarChanged":
					_ce = new ControlEvent(ControlEvent.SEEKBAR_CHANGED);
					_ce.time = e.time;
					break;

				case "seekChangeStart":
					_ce = new ControlEvent(ControlEvent.SEEK_CHANGE_START);
					break;

				case "seekChangeEnd":
					_ce = new ControlEvent(ControlEvent.SEEK_CHANGE_END);
					break;

				case "volumeChanged":
					_ce = new ControlEvent(ControlEvent.VOLUME_CHANGED);
					_ce.volume = e.volume;
					break;

				default:
					//dispatch default error event if no case is matched
					_ce = new ControlEvent(ControlEvent.DEFAULT);
					_ce.errorType = "control mediator onControlEvent default case error: " + e.type;
					break;
			}
			dispatch(_ce);
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		EVENT HANDLER FOR MAIN MEDIA WINDOW EVENTS			//
		//															//
		//////////////////////////////////////////////////////////////

		private function onMainMediaWindowEvent(e:MediaWindowEvent):void
		{
			switch (e.type)
			{
				case "mainWindowPlayStateChange":
					view.playPauseButton.toggle(e.playState);
					break;

				case "mainWindowClicked":
					fadeControlBar()
					break;

				case "mainWindowRollOut":
					fadeControlBar()
					break;

				case "mainWindowRollOver":
					fadeControlBar()
					break;

				case "mainWindowCurrentTimeChange":
					//send the current time to the view
					view.currentTime = e.time;
					break;

				case "mainWindowDurationChange":
					if (e.time)
					{
						//if there is a duration, send duration to view
						view.duration = e.time;
					} else {
						//if no duration, end function
						return
					}
					break;

				case "mainWindowBytesLoadedChange":
					view.bytesLoaded = e.bytes;
					break;

				case "mainWindowBytesTotalChange":
					view.size = e.bytes;
					break;

				case "mainWindowMediaError":
					onMediaError()
					break;

				default:
					trace("control onMainWindowEvent default case error: " + e.type);
					break;
			}
		}

		private function fadeControlBar():void
		{
			//TODO: control bar fade transition in/out
		}

		private function onMediaError():void
		{
			view.enabled = false;
		}

	}
}

