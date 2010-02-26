package org.robotlegs.utilities.lasyMediator
{
    import support.MockContextView;
    import support.MockContextViewMediator;
    import support.MockMediator;
    import support.MockView;
    import support.UIImpersonator;

    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import org.robotlegs.adapters.SwiftSuspendersInjector;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediator;
    import org.robotlegs.core.IMediatorMap;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    /**
     * @author eidiot
     */
    public class LasyMediatorMapTest
    {
        private var instance:LasyMediatorMap;
        private var contextView:Sprite;
        private var injector:IInjector;
        private var eventDispatcher:IEventDispatcher;

        [Before]
        public function setUp():void
        {
            contextView = new MockContextView();
            UIImpersonator.addChild(contextView);
            eventDispatcher = new EventDispatcher();
            injector = new SwiftSuspendersInjector();
            instance = new LasyMediatorMap(contextView, injector);
            //
            injector.mapValue(DisplayObjectContainer, contextView);
            injector.mapValue(IInjector, injector);
            injector.mapValue(IEventDispatcher, eventDispatcher);
            injector.mapValue(IMediatorMap, instance);
        }

        [After]
        public function tearDown():void
        {
            UIImpersonator.removeChild(contextView);
            injector.unmap(DisplayObjectContainer);
            injector.unmap(IInjector);
            injector.unmap(IEventDispatcher);
            injector.unmap(IMediatorMap);
        }

        [Test]
        public function mediator_is_mapped_and_created_for_view():void
        {
            instance.mapView(MockView, MockMediator, null, false, false);
            var mockView:MockView = new MockView();
            contextView.addChild(mockView);
            var mediator:IMediator = instance.createMediator(mockView);
            assertNotNull('Mediator should have been created ', mediator);
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));
        }

        [Test]
        public function mediator_is_mapped_added_and_removed():void
        {
            var mockView:MockView = new MockView();
            instance.mapView(MockView, MockMediator, null, false, false);
            contextView.addChild(mockView);
            var mediator:IMediator = instance.createMediator(mockView);
            assertNotNull('Mediator should have been created', mediator);
            assertTrue('Mediator should have been created', instance.hasMediator(mediator));
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));
            instance.removeMediator(mediator);
            assertFalse("Mediator Should Not Exist", instance.hasMediator(mediator));
            assertFalse("View Mediator Should Not Exist", instance.hasMediatorForView(mockView));
        }

        [Test]
        public function mediator_is_mapped_added_and_removed_by_view():void
        {
            var mockView:MockView = new MockView();
            instance.mapView(MockView, MockMediator, null, false, false);
            contextView.addChild(mockView);
            var mediator:IMediator = instance.createMediator(mockView);
            assertNotNull('Mediator should have been created', mediator);
            assertTrue('Mediator should have been created', instance.hasMediator(mediator));
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));
            instance.removeMediatorByView(mockView);
            assertFalse("Mediator should not exist", instance.hasMediator(mediator));
            assertFalse("View Mediator should not exist", instance.hasMediatorForView(mockView));
        }

        [Test]
        public function auto_register():void
        {
            instance.mapView(MockView, MockMediator, null, true, true);
            var mockView:MockView = new MockView();
            contextView.addChild(mockView);
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));
        }

        [Test(async)]
        public function mediator_is_kept_during_reparenting():void
        {
            var mockView:MockView = new MockView();
            instance.mapView(MockView, MockMediator, null, false, true);
            contextView.addChild(mockView);
            var mediator:IMediator = instance.createMediator(mockView);
            assertNotNull('Mediator should have been created', mediator);
            assertTrue('Mediator should have been created', instance.hasMediator(mediator));
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));

            var container:Sprite = new Sprite();
            contextView.addChild(container);
            container.addChild(mockView);

            Async.handleEvent(this, contextView, Event.ENTER_FRAME, delay_further, 500, {dispatcher:contextView, method:verify_mediator_survival, view:mockView, mediator: mediator});
        }

        private function verify_mediator_survival(event:Event, data:Object):void
        {
            var mockView:MockView = data.view;
            var mediator:IMediator = data.mediator;
            assertTrue("Mediator should exist", instance.hasMediator(mediator));
            assertTrue("View Mediator should exist", instance.hasMediatorForView(mockView));
        }

        [Test(async)]
        public function mediator_is_removed_with_view():void
        {
            var mockView:MockView = new MockView();
            instance.mapView(MockView, MockMediator, null, false, true);
            contextView.addChild(mockView);
            var mediator:IMediator = instance.createMediator(mockView);
            assertNotNull('Mediator should have been created', mediator);
            assertTrue('Mediator should have been created', instance.hasMediator(mediator));
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));
            assertTrue('onRegister method should be called', MockMediator(mediator).isRegistered);
            contextView.removeChild(mockView);
            assertTrue("Mediator should exist", instance.hasMediator(mediator));
            assertTrue("View Mediator should exist", instance.hasMediatorForView(mockView));
            Async.handleEvent(this, contextView, Event.ENTER_FRAME, delay_further, 500, {dispatcher:contextView, method:verify_mediator_removal, view:mockView, mediator:mediator});
        }

        private function verify_mediator_removal(event:Event, data:Object):void
        {
            var mockView:MockView = data.view;
            var mediator:IMediator = data.mediator;
            assertFalse("Mediator should not exist", instance.hasMediator(mediator));
            assertFalse("View Mediator should not exist", instance.hasMediatorForView(mockView));
            assertTrue('onRemove method should be called', MockMediator(mediator).isRemoved);
        }

        [Test]
        public function context_view_mediator_is_created_when_mapped():void
        {
            instance.mapView(MockContextView, MockContextViewMediator);
            assertTrue('Mediator should have been created for contextView', instance.hasMediatorForView(contextView));
            assertTrue('onRegister method should be called', MockContextViewMediator(instance.retrieveMediator(contextView)).isRegistered);
        }

        [Test]
        public function context_view_mediator_is_not_created_when_mapped_and_auto_create_is_false():void
        {
            instance.mapView(MockContextView, MockContextViewMediator, null, false);
            assertFalse('Mediator should NOT have been created for contextView', instance.hasMediatorForView(contextView));
        }

        [Test]
        public function unmap_view():void
        {
            instance.mapView(MockView, MockMediator);
            instance.unmapView(MockView);
            var mockView:MockView = new MockView();
            contextView.addChild(mockView);
            var hasMediator:Boolean = instance.hasMediatorForView(mockView);
            assertFalse('Mediator should NOT have been created for View Component', hasMediator);
        }

        [Test(async)]
        public function test_auto_remove_keep_map_data():void
        {
            instance.mapView(MockView, MockMediator);
            var mockView:MockView = new MockView();
            contextView.addChild(mockView);
            assertTrue('Mediator should have been created for View Component', instance.hasMediatorForView(mockView));
            contextView.removeChild(mockView);
            Async.handleEvent(this, contextView, Event.ENTER_FRAME, delay_further, 500, {dispatcher:contextView, method:verify_mediator_removal_and_add_again, view:mockView});
        }

        private function verify_mediator_removal_and_add_again(event:Event, data:Object):void
        {
            var mockView:MockView = data.view;
            assertFalse("View Mediator should not exist", instance.hasMediatorForView(mockView));
            contextView.addChild(mockView);
            assertTrue('Mediator should have been created for View Component again', instance.hasMediatorForView(mockView));
        }

        [Test]
        public function different_mediators_for_different_views():void
        {
            instance.mapView(MockView, MockMediator);
            var mockView1:MockView = new MockView();
            contextView.addChild(mockView1);
            var mockView2:MockView = new MockView();
            contextView.addChild(mockView2);
            //
            assertTrue('Mediator should have been created for View 1', instance.hasMediatorForView(mockView1));
            assertTrue('Mediator should have been created for View 2', instance.hasMediatorForView(mockView2));
            assertTrue("Should be different mediators", instance.retrieveMediator(mockView1) != instance.retrieveMediator(mockView2));
        }

        private function delay_further(event:Event, data:Object):void
        {
            Async.handleEvent(this, data.dispatcher, Event.ENTER_FRAME, data.method, 500, data);
            delete data.dispatcher;
            delete data.method;
        }
    }
}