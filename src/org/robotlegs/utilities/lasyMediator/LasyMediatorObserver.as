package org.robotlegs.utilities.lasyMediator
{
    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class LasyMediatorObserver
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>LasyMediatorObserver</code>.
         * @param contextView   Context view as event dispatcher.
         * @param mediatorMap   Lasy mediator map.
         * @param activated     If auto activate.
         */
        public function LasyMediatorObserver(contextView:DisplayObjectContainer,
                                             mediatorMap:LasyMediatorMap,
                                             activated:Boolean = true)
        {
            this.contextView = contextView;
            this.mediatorMap = mediatorMap;
            this.enabled = activated;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var contextView:DisplayObjectContainer;
        private var mediatorMap:LasyMediatorMap;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  enabled
        //------------------------------
        private var _enabled:Boolean = false;
        /**
         * If the observer is enabled.
         */
        public function get enabled():Boolean
        {
            return _enabled;
        }
        /**
         * @private
         */
        public function set enabled(value:Boolean):void
        {
            if (value != _enabled)
            {
                _enabled = value;
                _enabled ? addListeners() : removeListeners();
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function addListeners():void
        {
            contextView.addEventListener(LasyMediatorEvent.VIEW_ADDED, viewAddedHandler);
            contextView.addEventListener(LasyMediatorEvent.VIEW_REMOVED, viewRemovedHandler);
        }
        private function removeListeners():void
        {
            contextView.removeEventListener(LasyMediatorEvent.VIEW_ADDED, viewAddedHandler);
            contextView.removeEventListener(LasyMediatorEvent.VIEW_REMOVED, viewRemovedHandler);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function viewAddedHandler(event:LasyMediatorEvent):void
        {
            event.stopImmediatePropagation();
            mediatorMap.checkAddedView(event.view);
        }
        private function viewRemovedHandler(event:LasyMediatorEvent):void
        {
            event.stopImmediatePropagation();
            mediatorMap.checkRemovedView(event.view);
        }
    }
}