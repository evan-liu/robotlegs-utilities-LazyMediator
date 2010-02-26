package org.robotlegs.utilities.lasyMediator
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    /**
     * Lasy mediator events triggered by LasyMediatorActivator and handled by LasyMediatorObserver.
     * @author eidiot
     */
    public class LasyMediatorEvent extends Event
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
         * Construct a <code>LasyMediatorEvent</code>.
         * @param type  Type of the event.
         * @param view  The view componet being added/removed.
         */
        public function LasyMediatorEvent(type:String, view:DisplayObject)
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
            return new LasyMediatorEvent(type, _view);
        }
    }
}