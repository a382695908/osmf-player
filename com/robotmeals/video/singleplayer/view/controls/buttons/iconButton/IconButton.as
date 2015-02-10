/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.view.controls.buttons.iconButton
{
	import com.robotmeals.video.singleplayer.view.controls.buttons.IButtonComponent;
	import com.robotmeals.video.singleplayer.view.controls.buttons.regularButton.RegularButton;

	import flash.display.DisplayObject;

	public class IconButton extends RegularButton implements IButtonComponent
	{
		private var _icon:DisplayObject;

		public function IconButton()
		{
			super();
		}

		private function get icon ():DisplayObject
		{
			return _icon;
		}

		private function set icon(value:DisplayObject):void
		{
			_icon = _button
		}
	}
}

