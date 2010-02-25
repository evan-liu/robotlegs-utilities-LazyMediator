package support
{
    import flash.display.DisplayObject;
    import flash.display.Stage;
    /**
     * @author eidiot
     */
    public class UIImpersonator
    {
        //======================================================================
        //  Class properties
        //======================================================================
        //------------------------------
        //  stage
        //------------------------------
        private static var _stage:Stage;
        public static function get stage():Stage
        {
            return _stage;
        }
        //======================================================================
        //  Class public methods
        //======================================================================
        public static function initialize(stage:Stage):void
        {
            _stage = stage;
        }
        public static function addChild(child:DisplayObject):DisplayObject
        {
            return _stage ? _stage.addChild(child) : child;
        }
        public static function addChildAt(child:DisplayObject, index:int):DisplayObject
        {
            return _stage ? _stage.addChildAt(child, index) : child;
        }
        public static function contains(child:DisplayObject):Boolean
        {
            return _stage ? _stage.contains(child) : false;
        }
        public static function getChildAt(index:int):DisplayObject
        {
            return _stage ? _stage.getChildAt(index) : null;
        }
        public static function getChildByName(name:String):DisplayObject
        {
            return _stage ? _stage.getChildByName(name) : null;
        }
        public static function getChildIndex(child:DisplayObject):int
        {
            return _stage ? _stage.getChildIndex(child) : null;
        }
        public static function get numChildren():int
        {
            return _stage ? _stage.numChildren : 0;
        }
        public static function removeChild(child:DisplayObject):DisplayObject
        {
            return _stage ? _stage.removeChild(child) : child;
        }
        public static function removeChildAt(index:int):DisplayObject
        {
            return _stage ? _stage.removeChildAt(index) : null;
        }
        public static function setChildIndex(child:DisplayObject, index:int):void
        {
            if (_stage)
            {
                _stage.setChildIndex(child, index);
            }
        }
        public static function swapChildren(child1:DisplayObject, child2:DisplayObject):void
        {
            if (_stage)
            {
                _stage.swapChildren(child1, child2);
            }
        }
        public static function swapChildrenAt(index1:int, index2:int):void
        {
            if (_stage)
            {
                _stage.swapChildrenAt(index1, index2);
            }
        }
    }
}