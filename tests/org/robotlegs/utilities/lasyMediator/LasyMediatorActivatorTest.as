package org.robotlegs.utilities.lasyMediator
{
    import support.UIImpersonator;

    import org.flexunit.async.Async;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class LasyMediatorActivatorTest
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:LasyMediatorActivator;
        private var view:Sprite;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            view = new Sprite();
            instance = new LasyMediatorActivator(view);
        }
        [After]
        public function tearDown():void
        {
            if (view.parent)
            {
                view.parent.removeChild(view);
            }
        }
        [Test(async)]
        public function trigger_event_in_constructor_for_already_on_stage_view():void
        {
            UIImpersonator.addChild(view);
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_ADDED);
            instance = new LasyMediatorActivator(view);
        }
        [Test(async)]
        public function trigger_event_when_view_is_added_to_stage():void
        {
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_ADDED);
            UIImpersonator.addChild(view);
        }
        [Test(async)]
        public function trigger_event_when_view_is_removed_from_stage():void
        {
            UIImpersonator.addChild(view);
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_REMOVED);
            UIImpersonator.removeChild(view);
        }
        [Test(async)]
        public function trigger_event_added_after_removed_if_not_oneshot():void
        {
            UIImpersonator.addChild(view);
            UIImpersonator.removeChild(view);
            Async.proceedOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_ADDED);
            UIImpersonator.addChild(view);
        }
        [Test(async)]
        public function not_trigger_event_added_after_removed_if_oneshot():void
        {
            view = new Sprite();
            instance = new LasyMediatorActivator(view, true);
            UIImpersonator.addChild(view);
            UIImpersonator.removeChild(view);
            Async.failOnEvent(this, UIImpersonator.stage, LasyMediatorEvent.VIEW_ADDED);
            UIImpersonator.addChild(view);
        }
    }
}