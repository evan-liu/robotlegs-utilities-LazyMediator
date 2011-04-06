package org.robotlegs.utilities.lazy
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    /**
     * @author eidiot, darscan
     */
    public class LazyMediatorMxmlActivator
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>LazyMediatorMxmlActivator</code>.
         */
        public function LazyMediatorMxmlActivator()
        {
        }
		//======================================================================
		//  Properties
		//======================================================================
		public function set view(value:DisplayObject):void
		{
			_view = value;
			if (_view.stage)
			{
				triggerActivateMediatorEvent();
			}
			else
			{
				_view.addEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
			}
		}
        //======================================================================
        //  Variables
        //======================================================================
        private var _view:DisplayObject;
        //======================================================================
        //  Private methods
        //======================================================================
        private function triggerActivateMediatorEvent():void
        {
            _view.dispatchEvent(new LazyMediatorEvent(LazyMediatorEvent.VIEW_ADDED, _view));
            _view.addEventListener(Event.REMOVED_FROM_STAGE, view_removedFromStageHandler);
        }
        private function triggerDeactivateMediatorEvent():void
        {
            _view.dispatchEvent(new LazyMediatorEvent(LazyMediatorEvent.VIEW_REMOVED, _view));
            _view.addEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function view_addedToStageHandler(event:Event):void
        {
            _view.removeEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
            triggerActivateMediatorEvent();
        }
        private function view_removedFromStageHandler(event:Event):void
        {
            _view.removeEventListener(Event.REMOVED_FROM_STAGE, view_removedFromStageHandler);
            triggerDeactivateMediatorEvent();
        }
    }
}