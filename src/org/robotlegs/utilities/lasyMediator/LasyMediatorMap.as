/*
 * Copyright (c) 2010 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.utilities.lasyMediator
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;
	
	public class LasyMediatorMap extends MediatorMap
	{
		public function LasyMediatorMap(contextView:DisplayObjectContainer, injector:IInjector, reflector:IReflector)
		{
			super(contextView, injector, reflector);
		}
		
		//---------------------------------------------------------------------
		//  Internal
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function addListeners():void
		{
			if (contextView && enabled && _active)
			{
				contextView.addEventListener(LasyMediatorEvent.VIEW_ADDED, onViewAdded, useCapture, 0, true);
				contextView.addEventListener(LasyMediatorEvent.VIEW_REMOVED, onViewRemoved, useCapture, 0, true);
			}
		}
		
		/**
		 * @private
		 */
		override protected function removeListeners():void
		{
			if (contextView && enabled && _active)
			{
				contextView.removeEventListener(LasyMediatorEvent.VIEW_ADDED, onViewAdded, useCapture);
				contextView.removeEventListener(LasyMediatorEvent.VIEW_REMOVED, onViewRemoved, useCapture);
			}
		}
	
	}
}