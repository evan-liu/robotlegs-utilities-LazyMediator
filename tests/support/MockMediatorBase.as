package support
{
    import org.robotlegs.mvcs.Mediator;
    /**
     * @author eidiot
     */
    public class MockMediatorBase extends Mediator
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  isRegistered
        //------------------------------
        protected var _isRegistered:Boolean = false;
        public function get isRegistered():Boolean
        {
            return _isRegistered;
        }
        //------------------------------
        //  isRemoved
        //------------------------------
        protected var _isRemoved:Boolean = false;
        public function get isRemoved():Boolean
        {
            return _isRemoved;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function onRegister():void
        {
            _isRegistered = true;
        }
        override public function onRemove():void
        {
            _isRemoved = true;
        }
    }
}
