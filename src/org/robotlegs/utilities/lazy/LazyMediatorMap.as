/*
 * Copyright (c) 2010 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.utilities.lazy
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;
	
	public class LazyMediatorMap extends MediatorMap
	{
		public function LazyMediatorMap(contextView:DisplayObjectContainer, injector:IInjector, reflector:IReflector)
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
			if (contextView && enabled)
			{
				contextView.addEventListener(LazyMediatorEvent.VIEW_ADDED, onViewAdded, useCapture, 0, true);
				contextView.addEventListener(LazyMediatorEvent.VIEW_REMOVED, onViewRemoved, useCapture, 0, true);
			}
		}
		
		/**
		 * @private
		 */
		override protected function removeListeners():void
		{
			if (contextView && enabled)
			{
				contextView.removeEventListener(LazyMediatorEvent.VIEW_ADDED, onViewAdded, useCapture);
				contextView.removeEventListener(LazyMediatorEvent.VIEW_REMOVED, onViewRemoved, useCapture);
			}
		}
	
	}
}