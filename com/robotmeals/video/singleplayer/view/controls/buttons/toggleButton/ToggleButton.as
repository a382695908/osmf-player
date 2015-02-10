/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.buttons.toggleButton
{
	import com.robotmeals.video.singleplayer.utils.HitAreaUtil;
	import com.robotmeals.video.singleplayer.view.controls.buttons.IButtonComponent;
	import com.robotmeals.video.singleplayer.view.controls.buttons.regularButton.RegularButton;

	public class ToggleButton extends RegularButton implements IButtonComponent
	{
		public var button1:PlayButton;
		public var button2:PauseButton;

		public function ToggleButton()
		{
			//create hit areas for buttons
			var hitArea:HitAreaUtil = new HitAreaUtil();
			hitArea.createHitArea(button1, button1.width, button1.height, 0, 0);
			hitArea.createHitArea(button2, button2.width, button2.height, 0, 0);
		}

		public function toggle(value:String):void
		{	
			//test for play state and adjust button views
			switch (value)
			{
				case "playing":
					button1.visible = false;
					button2.visible = true;
					break;

				case "paused":
					button1.visible = true;
					button2.visible = false;
					break;

				case "stopped":
					button1.visible = true;
					button2.visible = false;
					break;

				default:
					break;
			}
		}
	}
}

