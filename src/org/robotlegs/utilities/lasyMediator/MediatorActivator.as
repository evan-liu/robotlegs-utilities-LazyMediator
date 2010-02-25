package org.robotlegs.utilities.lasyMediator
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    /**
     * @author eidiot
     */
    public class MediatorActivator
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>MediatorActivator</code>.
         */
        public function MediatorActivator(view:DisplayObject)
        {
            this.view = view;
            view.addEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var view:DisplayObject;
        //======================================================================
        //  Event handlers
        //======================================================================
        private function view_addedToStageHandler(event:Event):void
        {
            view.removeEventListener(Event.ADDED_TO_STAGE, view_addedToStageHandler);
            view.stage.dispatchEvent(new LasyMediatorEvent(LasyMediatorEvent.VIEW_ADDED, view));
            view.addEventListener(Event.REMOVED_FROM_STAGE, view_removedFromStageHandler);
        }
        private function view_removedFromStageHandler(event:Event):void
        {
            view.removeEventListener(Event.REMOVED_FROM_STAGE, view_removedFromStageHandler);
            view.stage.dispatchEvent(new LasyMediatorEvent(LasyMediatorEvent.VIEW_REMOVED, view));
        }
    }
}