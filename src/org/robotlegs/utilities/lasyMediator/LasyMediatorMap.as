package org.robotlegs.utilities.lasyMediator
{
    import org.robotlegs.base.ContextError;
    import org.robotlegs.base.ViewMapBase;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediator;
    import org.robotlegs.core.IMediatorMap;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.utils.Dictionary;
    /**
     * @author eidiot
     */
    public class LasyMediatorMap extends ViewMapBase implements IMediatorMap
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>LasyMediatorMap</code>.
         */
        public function LasyMediatorMap(contextView:DisplayObjectContainer, injector:IInjector)
        {
            super(contextView, injector);
            kepper = new LasyMediatorObserver(contextView, this);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var kepper:LasyMediatorObserver;
        private var mappingDataByViewClass:Dictionary = new Dictionary(true);
        private var mediatorsMarkedForRemoval:Dictionary = new Dictionary();
        private var hasMediatorsMarkedForRemoval:Boolean = false;
        //======================================================================
        //  Overridden properties: ViewMapBase
        //======================================================================
        override public function set enabled(value:Boolean):void
        {
            if (value != _enabled)
            {
                _enabled = value;
                kepper.enabled = value;
            }
        }
        //======================================================================
        //  Public methods: IMediatorMap
        //======================================================================
        /**
         * @inheritDoc
         */
        public function mapView(viewClassOrName:*, mediatorClass:Class, injectViewAs:Class = null, autoCreate:Boolean = true, autoRemove:Boolean = true):void
        {
            if (!(viewClassOrName is Class))
            {
                throw new ContextError("Only view class can be used in LasyMediatorMap.");
            }
            // TODO Check if the mediatorClass is classExtendsOrImplements IMediator
            var data:MappingData = new MappingData();
            data.mediatorClass = mediatorClass;
            data.autoCreate = autoCreate;
            data.autoRemove = autoRemove;
            data.typedViewClass = injectViewAs ? injectViewAs : viewClassOrName;
            mappingDataByViewClass[viewClassOrName] = data;
            // TODO Fix (_contextView is viewClassOrName) to a better way
            if (autoCreate && _contextView && (_contextView is viewClassOrName))
            {
                createMediator(contextView);
            }
            activate();
        }
        /**
         * @inheritDoc
         */
        public function unmapView(viewClassOrName:*):void
        {
            if (!(viewClassOrName is Class))
            {
                throw new ContextError("Only view class can be used in LasyMediatorMap.");
            }
            delete mappingDataByViewClass[viewClassOrName];
        }
        /**
         * @inheritDoc
         */
        public function createMediator(viewComponent:Object):IMediator
        {
            if (!viewComponent)
            {
                return null;
            }
            var data:MappingData = getMappingDataByView(viewComponent);
            if (!data)
            {
                return null;
            }
            var mediator:IMediator = data.mediatorInstance;
            if (!mediator && data.mediatorClass)
            {
                injector.mapValue(data.typedViewClass, viewComponent);
                mediator = injector.instantiate(data.mediatorClass);
                injector.unmap(data.typedViewClass);
                registerMediator(viewComponent, mediator);
            }
            return mediator;
        }
        /**
         * @inheritDoc
         */
        public function registerMediator(viewComponent:Object, mediator:IMediator):void
        {
            injector.mapValue(getClass(mediator), mediator);
            var data:MappingData = getMappingDataByView(viewComponent);
            data.viewInstance = viewComponent;
            data.mediatorInstance = mediator;
            mediator.setViewComponent(viewComponent);
            mediator.preRegister();
        }
        /**
         * @inheritDoc
         */
        public function removeMediator(mediator:IMediator):IMediator
        {
            if (mediator)
            {
                var viewClass:Class = getClass(mediator.getViewComponent());
                delete mappingDataByViewClass[viewClass];
                mediator.preRemove();
                mediator.setViewComponent(null);
                injector.unmap(getClass(mediator));
            }
            return mediator;
        }
        /**
         * @inheritDoc
         */
        public function removeMediatorByView(viewComponent:Object):IMediator
        {
            return removeMediator(retrieveMediator(viewComponent));
        }
        /**
         * @inheritDoc
         */
        public function retrieveMediator(viewComponent:Object):IMediator
        {
            var data:MappingData = getMappingDataByView(viewComponent);
            return data ? data.mediatorInstance : null;
        }
        /**
         * @inheritDoc
         */
        public function hasMediatorForView(viewComponent:Object):Boolean
        {
            var data:MappingData = getMappingDataByView(viewComponent);
            return data && data.mediatorInstance;
        }
        /**
         * @inheritDoc
         */
        public function hasMediator(mediator:IMediator):Boolean
        {
            return hasMediatorForView(mediator.getViewComponent());
        }
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Check the view is added to contextView.
         */
        public function checkAddedView(view:Object):void
        {
            if (mediatorsMarkedForRemoval[view])
            {
                delete mediatorsMarkedForRemoval[view];
                return;
            }
            var data:MappingData = getMappingDataByView(view);
            if (data && data.autoCreate)
            {
                createMediator(view);
            }
        }
        /**
         * Check the view is removed from contextView.
         */
        public function checkRemovedView(view:Object):void
        {
            if (mediatorsMarkedForRemoval[view])
            {
                return;
            }
            var data:MappingData = getMappingDataByView(view);
            if (data && data.autoRemove)
            {
                mediatorsMarkedForRemoval[view] = view;
                if (!hasMediatorsMarkedForRemoval)
                {
                    hasMediatorsMarkedForRemoval = true;
                    contextView.addEventListener(Event.ENTER_FRAME, removeMediatorLater);
                }
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getMappingDataByView(view:Object):MappingData
        {
            return mappingDataByViewClass[getClass(view)];
        }
        private function getClass(target:Object):Class
        {
            return target ? target.constructor as Class : null;
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function removeMediatorLater(event:Event):void
        {
            contextView.removeEventListener(Event.ENTER_FRAME, removeMediatorLater);
            for each (var view:DisplayObject in mediatorsMarkedForRemoval)
            {
                if (!view.stage)
                {
                    removeMediatorByView(view);
                }
                delete mediatorsMarkedForRemoval[view];
            }
            hasMediatorsMarkedForRemoval = false;
        }
    }
}

import org.robotlegs.core.IMediator;
class MappingData
{
    //-- View data --//
    public var viewInstance:Object;
    public var typedViewClass:Class;
    //-- Mediator data --//
    public var mediatorClass:Class;
    public var mediatorInstance:IMediator;
    //-- Mapping flags --//
    public var autoCreate:Boolean;
    public var autoRemove:Boolean;
}