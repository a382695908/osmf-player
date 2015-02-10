/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.controller
{
	import com.robotmeals.video.singleplayer.model.MediaPlayerModel;
	import com.robotmeals.video.singleplayer.controller.events.XMLServiceEvent;

	import flash.events.Event;

	import org.robotlegs.mvcs.Command;

	public class SetModelDataCommand extends Command
	{

		[Inject]
		public var event:XMLServiceEvent;

		[Inject]
		public var model:MediaPlayerModel;

		override public function execute():void
		{
			//send the xml to the model
			model.data = event.xml;
		}
	}
}

