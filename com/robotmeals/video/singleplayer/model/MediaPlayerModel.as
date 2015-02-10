/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.model
{

	import com.robotmeals.video.singleplayer.controller.events.ModelEvent;
	import com.robotmeals.video.singleplayer.model.vo.MediaVO;

	import org.osmf.media.URLResource;
	import org.robotlegs.mvcs.Actor;

	public class MediaPlayerModel extends Actor
	{
		private var _data:XML;

		public var _totalBytes:Number;

		public var _bytesLoaded:Number;

		public var _duration:Number;

		public var _currentTime:Number;

		public function MediaPlayerModel()
		{
			super();
		}

		//////////////////////////////////////////////////////////////
		//															//
		// 		GETTERS AND SETTERS									//
		//															//
		//////////////////////////////////////////////////////////////

		public function set data(xml:XML):void
		{
			_data = xml;

			//TODO: add tests to verify acceptable data

			//create a new model event to dispatch to the application
			var modelEvent:ModelEvent = new ModelEvent(ModelEvent.MODEL_READY);

			//create a new value object to hold the information about the media
			var mediaVO:MediaVO = new MediaVO;

			//set the media title
			mediaVO.title = _data.mediaInfo.mediaTitle;

			//set the source URL of the video
			mediaVO.urlResource = new URLResource(_data.mediaInfo.mediaURL);

			//set the initial volume by converting from xml (number 1-10) into value between 0 and 1
			var _volume:Number = _data.mediaInfo.mediaVolume / 10;
			mediaVO.volume = _volume;

			//attach the media value object to the event
			modelEvent.mediaVO = mediaVO;

			//dispatch the model ready event to the event bus
			dispatch(modelEvent);
		}
	}
}

