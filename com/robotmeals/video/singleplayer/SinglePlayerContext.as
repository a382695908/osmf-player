/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer
{
	import com.robotmeals.video.singleplayer.controller.SetModelDataCommand;
	import com.robotmeals.video.singleplayer.controller.StartupApplicationCommand;
	import com.robotmeals.video.singleplayer.controller.events.ModelEvent;
	import com.robotmeals.video.singleplayer.controller.events.XMLServiceEvent;
	import com.robotmeals.video.singleplayer.model.MediaPlayerModel;
	import com.robotmeals.video.singleplayer.services.IService;
	import com.robotmeals.video.singleplayer.services.XMLService;
	import com.robotmeals.video.singleplayer.view.controls.control.horizontalControlBar.HorizontalControlBarComponent;
	import com.robotmeals.video.singleplayer.view.controls.control.IControlComponent;
	import com.robotmeals.video.singleplayer.view.controls.ControlMediator;
	import com.robotmeals.video.singleplayer.view.mediaWindow.MediaWindow;
	import com.robotmeals.video.singleplayer.view.mediaWindow.MediaWindowMediator;
	import com.robotmeals.video.singleplayer.view.text.Title;
	import com.robotmeals.video.singleplayer.view.text.TitleMediator;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	import org.osmf.events.LoadEvent;
	import org.osmf.events.TimeEvent;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	public class SinglePlayerContext extends Context
	{

		public function SinglePlayerContext(contextView:DisplayObjectContainer=null)
		{
			super(contextView);
		}

		override public function startup():void
		{
			//trace("STARTUP");

			// get reference to the stage
			var main:Main = contextView as Main;

			//startup event mapping
			commandMap.mapEvent(ContextEvent.STARTUP, StartupApplicationCommand, ContextEvent);
			commandMap.mapEvent(XMLServiceEvent.XML_LOADED, SetModelDataCommand, XMLServiceEvent);

			//map views to their mediators
			mediatorMap.mapView(MediaWindow, MediaWindowMediator);
			mediatorMap.mapView(Title, TitleMediator);
			mediatorMap.mapView(HorizontalControlBarComponent, ControlMediator);

			//mediate items already on the stage in the .fla at runtime
			mediatorMap.createMediator(main.controlBar);

			//inject references to the models and services
			injector.mapSingleton(MediaPlayerModel);
			injector.mapSingletonOf(IService, XMLService);
			injector.mapSingletonOf(IControlComponent, HorizontalControlBarComponent); 
			injector.mapSingleton(MediaWindow);

			//start robotlegs
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));

			super.startup();
		}
	}
}

