/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.mediaWindow
{
	import com.robotmeals.video.singleplayer.controller.events.ControlEvent;
	import com.robotmeals.video.singleplayer.controller.events.MediaWindowEvent;
	import com.robotmeals.video.singleplayer.controller.events.ModelEvent;
	import com.robotmeals.video.singleplayer.model.MediaPlayerModel;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.osmf.events.LoadEvent;
	import org.osmf.events.MediaErrorEvent;
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.events.PlayEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaPlayer;
	import org.osmf.traits.PlayState;
	import org.robotlegs.mvcs.Mediator;

	public class MediaWindowMediator extends Mediator
	{

		[Inject]
		public var view:MediaWindow;

		private var _mwe:MediaWindowEvent;

		override public function onRegister():void
		{
			//listen for model event
			eventMap.mapListener(eventDispatcher, ModelEvent.MODEL_READY, onModelReady);

			//set the resource to null until the model sends the ready notification
			view.resource = null;

			//listen for control bar events
			eventMap.mapListener(eventDispatcher, ControlEvent.VOLUME_CHANGED, onControlBarEvent);
			eventMap.mapListener(eventDispatcher, ControlEvent.FULLSCREEN_PRESSED, onControlBarEvent);
			eventMap.mapListener(eventDispatcher, ControlEvent.SEEKBAR_CHANGED, onControlBarEvent);
			eventMap.mapListener(eventDispatcher, ControlEvent.SEEK_CHANGE_END, onControlBarEvent);
			eventMap.mapListener(eventDispatcher, ControlEvent.SEEK_CHANGE_START, onControlBarEvent);
			eventMap.mapListener(eventDispatcher, ControlEvent.PLAY_PAUSE_PRESSED, onControlBarEvent);

			//listen for media window events
			view.mediaPlayer.addEventListener(LoadEvent.BYTES_LOADED_CHANGE, onLoadEvent);
			view.mediaPlayer.addEventListener(LoadEvent.BYTES_TOTAL_CHANGE, onLoadEvent);
			view.mediaPlayer.addEventListener(TimeEvent.DURATION_CHANGE, onTimeEvent);
			view.mediaPlayer.addEventListener(TimeEvent.CURRENT_TIME_CHANGE, onTimeEvent);
			view.mediaPlayer.addEventListener(TimeEvent.COMPLETE, onTimeEvent);

			view.mediaPlayer.addEventListener(MediaErrorEvent.MEDIA_ERROR, onMediaError);

			view.mediaPlayer.addEventListener(PlayEvent.PLAY_STATE_CHANGE, onPlayStateChangeEvent);

			//listen for interaction with video window
			view.addEventListener(MouseEvent.CLICK, onViewMouseEvent);
			view.addEventListener(MouseEvent.CLICK, onViewMouseEvent);
			view.addEventListener(MouseEvent.ROLL_OVER, onViewMouseEvent);
			view.addEventListener(MouseEvent.ROLL_OUT, onViewMouseEvent);
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		EVENT HANDLERS FOR MODEL EVENTS						//
		//															//
		//////////////////////////////////////////////////////////////

		private function onModelReady(e:ModelEvent):void
		{
			//trace("MEDIA WINDOW MEDIATOR ON MODEL READY");

			//tell the media window its URL resource
			view.resource = e.mediaVO.urlResource;

			//set the initial volume
			view.mediaPlayer.volume = e.mediaVO.volume;
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		EVENT HANDLERS FOR VIEW EVENTS						//
		//															//
		//////////////////////////////////////////////////////////////

		private function onTimeEvent(e:TimeEvent):void
		{
			switch (e.type)
			{
				case "currentTimeChange":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_CURRENT_TIME_CHANGE);
					_mwe.time = e.time;
					break;

				case "durationChange":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_DURATION_CHANGE);
					_mwe.time = e.time;
					break;

				case "complete":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_LOAD_COMPLETE);
					_mwe.time = e.time;
					//TODO: do something when movie finishes playing
					break;

				default:
					_mwe = new MediaWindowEvent(MediaWindowEvent.DEFAULT);
					_mwe.errorType = "media window onTimeEvent default case error: "+e.type;
					break;
			}
			dispatch(_mwe);
		}

		private function onLoadEvent(e:LoadEvent):void
		{
			switch (e.type)
			{
				case "bytesLoadedChange":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_BYTES_LOADED_CHANGE);
					_mwe.bytes = e.bytes;
					break;

				case "bytesTotalChange":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_BYTES_TOTAL_CHANGE);
					_mwe.bytes = e.bytes;
					break;

				default:
					//dispatch default error event if no case is matched
					_mwe = new MediaWindowEvent(MediaWindowEvent.DEFAULT);
					_mwe.errorType = "media window onLoadEvent default case error: "+e.type;
					break;
			}
			dispatch(_mwe);
		}

		private function onMediaError(e:MediaErrorEvent):void
		{
			switch (e.type)
			{
				case "mediaError":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_MEDIA_ERROR);
					_mwe.errorType = e.type;
					break;

				default:
					//dispatch default error event if no case is matched
					_mwe = new MediaWindowEvent(MediaWindowEvent.DEFAULT);
					_mwe.errorType = "media window onMediaError default case error: "+e.type;
					break;
			}
			dispatch(_mwe);
		}

		private function onPlayStateChangeEvent(e:PlayEvent):void
		{
			switch (e.type)
			{
				case "playStateChange":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_PLAY_STATE_CHANGE);
					_mwe.playState = e.playState;
					break;

				default:
					//dispatch default error event if no case is matched
					_mwe = new MediaWindowEvent(MediaWindowEvent.DEFAULT);
					_mwe.errorType = "media window onMediaError default case error: "+e.type;
					break;
			}
			dispatch(_mwe);
		}

		private function onViewMouseEvent(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "click":
					trace("media Player clicked");
					view.mediaPlayer.playing ? view.mediaPlayer.pause() : view.mediaPlayer.play();
					break;

				case "rollOver":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_ROLL_OVER);
					dispatch(_mwe)
					break;

				case "rollOut":
					_mwe = new MediaWindowEvent(MediaWindowEvent.MAIN_WINDOW_ROLL_OUT);
					dispatch(_mwe)
					break;

				default:
					break;
			}

		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		EVENT HANDLER FOR CONTROL BAR EVENTS				//
		//															//
		//////////////////////////////////////////////////////////////

		private function onControlBarEvent(e:ControlEvent):void
		{
			switch (e.type)
			{
				case "volumeChanged":
					view.mediaPlayer.volume = e.volume;
					break;

				case "fullScreenPressed":
					//TODO: toggle fullscreen mode on/off
					break;

				case "playPausePressed":
					view.mediaPlayer.playing ? view.mediaPlayer.pause() : view.mediaPlayer.play();
					break;

				case "seekBarChanged":
					view.mediaPlayer.seek(e.time);
					break;

				case "seekChangeEnd":
					view.mediaPlayer.seek(e.time);
					view.mediaPlayer.play();
					break;

				case "seekChangeStart":
					view.mediaPlayer.pause();
					break;

				default:
					break;
			}
		}
	}
}

