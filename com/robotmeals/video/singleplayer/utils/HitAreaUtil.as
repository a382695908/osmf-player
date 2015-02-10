/*
 * Author: Jeff Foster: jobs@foster2.com
 *
 * Copyright 2010 Jeff Foster. All rights reserved.
 *
 *
 */

package com.robotmeals.video.singleplayer.utils
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class HitAreaUtil
	{

		public function createHitArea(d:MovieClip, width:Number, height:Number, xValue:Number, yValue:Number):void
		{
			//create new sprite and set its dimensions
			var hit:Sprite = new Sprite();

			//draw graphics in sprite and add to stage
			hit.graphics.beginFill(0xff00ff);
			hit.graphics.lineTo(width, 0);
			hit.graphics.lineTo(width, height);
			hit.graphics.lineTo(0, height);
			hit.graphics.lineTo(0, 0);
			hit.x = xValue;
			hit.y = yValue;
			d.addChild(hit);
			//you can comment out the following line
			//if you need to see the bright pink hit area:
			hit.visible = false;
			d.hitArea = hit;
		}
	}
}

