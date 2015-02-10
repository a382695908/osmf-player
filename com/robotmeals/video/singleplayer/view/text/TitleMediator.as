/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.text
{
	import com.robotmeals.video.singleplayer.controller.events.MediaWindowEvent;
	import com.robotmeals.video.singleplayer.controller.events.ModelEvent;
	import com.robotmeals.video.singleplayer.controller.events.XMLServiceEvent;

	import org.robotlegs.mvcs.Mediator;

	public class TitleMediator extends Mediator
	{

		[Inject]
		public var view:Title;

		override public function onRegister():void
		{
			//listen for model event
			eventMap.mapListener(eventDispatcher, ModelEvent.MODEL_READY, onModelReady);
			eventMap.mapListener(eventDispatcher, XMLServiceEvent.XML_LOAD_FAIL, onXMLFail);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.MAIN_WINDOW_MEDIA_ERROR, onMediaError);
			eventMap.mapListener(eventDispatcher, MediaWindowEvent.DEFAULT, onDefault);
		}

		private function onModelReady(e:ModelEvent):void
		{
			trace("TITLE ON MODEL READY");
			view.text = e.mediaVO.title;
		}

		private function onXMLFail(e:XMLServiceEvent):void
		{
			view.text = "XML ERROR";
		}

		private function onMediaError(e:MediaWindowEvent):void
		{
			view.text = "MEDIA ERROR: "+ e.errorType;
		}

		private function onDefault(e:MediaWindowEvent):void
		{
			view.text = "DEFAULT EVENT ERROR: "+ e.type;
		}
	}
}

