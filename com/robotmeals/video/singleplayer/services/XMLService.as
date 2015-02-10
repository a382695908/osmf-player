/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.services
{
	import com.robotmeals.video.singleplayer.controller.events.XMLServiceEvent;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import org.robotlegs.mvcs.Actor;

	public class XMLService extends Actor implements IService
	{
		private var _xmlURL:String = "SinglePlayer.xml";

		private var _xmlLoader:URLLoader

		public function XMLService()
		{
			super();
		}

		public function init():void
		{
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, onLoaded);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		}

		public function loadData():void
		{
			_xmlLoader.load(new URLRequest(_xmlURL));
		}

		private function onLoaded(e:Event):void
		{
			//trace("XML LOAD SUCCESS");
			var xml:XML = new XML(e.target.data);
			var xmlLoadedEvent:XMLServiceEvent = new XMLServiceEvent(XMLServiceEvent.XML_LOADED);
			xmlLoadedEvent.xml = xml;
			dispatch(xmlLoadedEvent);
		}

		private function onLoadError(e:IOErrorEvent):void
		{
			//trace("XML LOADING FAILED");
			var xml:XML = new XML(e.target.data);
			var xmlFailedEvent:XMLServiceEvent = new XMLServiceEvent(XMLServiceEvent.XML_LOAD_FAIL);
			xmlFailedEvent.xml = xml;
			dispatch(xmlFailedEvent);
		}
	}
}

