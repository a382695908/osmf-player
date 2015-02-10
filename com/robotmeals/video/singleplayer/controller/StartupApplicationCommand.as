/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.controller
{
	import com.robotmeals.video.singleplayer.services.IService;

	import org.robotlegs.mvcs.Command;

	public class StartupApplicationCommand extends Command
	{

		[Inject]
		public var service:IService;

		override public function execute():void
		{
			//intialize the service and load the data into the model
			service.init();
			service.loadData();
		}
	}
}

