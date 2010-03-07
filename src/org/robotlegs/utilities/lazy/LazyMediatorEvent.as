package org.robotlegs.utilities.lazy
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    /**
     * Lazy mediator events triggered by LazyMediatorActivator and handled by LazyMediatorObserver.
     * @author eidiot
     */
    public class LazyMediatorEvent extends Event
    {
        //======================================================================
        //  Class constants
        //======================================================================
        /**
         * Trigger when a view is added to stage.
         */
        public static const VIEW_ADDED:String = "viewAdded";
        /**
         * Trigger when a view is removed from stage.
         */
        public static const VIEW_REMOVED:String = "viewRemoved";
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>LazyMediatorEvent</code>.
         * @param type  Type of the event.
         * @param view  The view componet being added/removed.
         */
        public function LazyMediatorEvent(type:String, view:DisplayObject)
        {
            super(type, true);
            _view = view;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  view
        //------------------------------
        private var _view:DisplayObject;
        /**
         * The view componet being added/removed.
         */
        public function get view():DisplayObject
        {
            return _view;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function clone():Event
        {
            return new LazyMediatorEvent(type, _view);
        }
    }
}