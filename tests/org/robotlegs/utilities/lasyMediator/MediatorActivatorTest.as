package org.robotlegs.utilities.lasyMediator
{
    import asunit4.async.Async;

    import support.UIImpersonator;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class MediatorActivatorTest
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:MediatorActivator;
        private var view:Sprite;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            view = new Sprite();
            instance = new MediatorActivator(view);
        }
        [After]
        public function tearDown():void
        {
            instance = null;
            if (view.parent)
            {
                view.parent.removeChild(view);
            }
            view = null;
        }
        [Test(async)]
        public function test_trigger_event_in_constructor_for_already_on_stage_view():void
        {
            UIImpersonator.addChild(view);
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_ADDED);
            instance = new MediatorActivator(view);
        }
        [Test(async)]
        public function test_add_view_to_stage_trigger_event():void
        {
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_ADDED);
            UIImpersonator.addChild(view);
        }
        [Test(async)]
        public function test_remove_view_to_stage_trigger_event():void
        {
            UIImpersonator.addChild(view);
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_REMOVED);
            UIImpersonator.removeChild(view);
        }
    }
}