package org.robotlegs.utilities.lasyMediator
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    /**
     * @author eidiot
     */
    public class LasyMediatorEvent extends Event
    {
        //======================================================================
        //  Class constants
        //======================================================================
        public static const VIEW_ADDED:String = "viewAdded";
        public static const VIEW_REMOVED:String = "viewRemoved";
        //======================================================================
        //  Constructor
        //======================================================================
        public function LasyMediatorEvent(type:String, view:DisplayObject)
        {
            super(type);
            _view = view;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  view
        //------------------------------
        private var _view:DisplayObject;
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