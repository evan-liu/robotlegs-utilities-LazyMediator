package org.robotlegs.utilities.lazy
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    /**
     * @author eidiot
     */
    public class LazyMediatorActivator
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>LazyMediatorActivator</code>.
         * @param view      View target.
         * @param oneShot   If stop when the view is removed from stage.
         */
        public function LazyMediatorActivator(view:DisplayObject, oneShot:Boolean = false)
        {
            this.view = view;
            this.oneShot = oneShot;
            if (view.stage)
            {
                triggerActivateMediatorEvent();
            }
            else
            {
                view.addEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
            }
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var view:DisplayObject;
        private var oneShot:Boolean;
        //======================================================================
        //  Private methods
        //======================================================================
        private function triggerActivateMediatorEvent():void
        {
            view.dispatchEvent(new LazyMediatorEvent(LazyMediatorEvent.VIEW_ADDED, view));
            view.addEventListener(Event.REMOVED_FROM_STAGE, view_removedFromStageHandler);
        }
        private function triggerDeactivateMediatorEvent():void
        {
            view.dispatchEvent(new LazyMediatorEvent(LazyMediatorEvent.VIEW_REMOVED, view));
            if (!oneShot)
            {
                view.addEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
            }
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function view_addedToStageHandler(event:Event):void
        {
            view.removeEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
            triggerActivateMediatorEvent();
        }
        private function view_removedFromStageHandler(event:Event):void
        {
            view.removeEventListener(Event.REMOVED_FROM_STAGE, view_removedFromStageHandler);
            triggerDeactivateMediatorEvent();
        }
    }
}