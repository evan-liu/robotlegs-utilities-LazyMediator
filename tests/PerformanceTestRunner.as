package
{
    import support.MockMediator;
    import support.MockView;

    import com.gskinner.performance.PerformanceTest;
    import com.gskinner.performance.TextLog;
    import com.gskinner.performance.XMLLog;

    import org.robotlegs.adapters.SwiftSuspendersInjector;
    import org.robotlegs.adapters.SwiftSuspendersReflector;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediatorMap;
    import org.robotlegs.utilities.lazy.LazyMediatorMap;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.IEventDispatcher;
    import flash.text.TextField;
    import flash.text.TextFormat;
    /**
     * @author eidiot
     */
    public class PerformanceTestRunner extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function PerformanceTestRunner()
        {
            super();
            build();
            startTest();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var outTf:TextField;
        private var testContainer:Sprite;
        //======================================================================
        //  Private methods
        //======================================================================
        private function startTest():void
        {
            var injector:IInjector = new SwiftSuspendersInjector();
            var mediatorMap:LazyMediatorMap = new LazyMediatorMap(this, injector, new SwiftSuspendersReflector());
            injector.mapValue(IEventDispatcher, this);
            injector.mapValue(DisplayObjectContainer, this);
            injector.mapValue(IMediatorMap, mediatorMap);
            //
            mediatorMap.mapView(MockView, MockMediator);
            var i:int = 10;
            testContainer = this;
            while (i-- > 0)
            {
                var newContainer:Sprite = new Sprite();
                testContainer.addChild(newContainer);
                testContainer = newContainer;
            }
            PerformanceTest.run(addView, "Add view test", 5, 1000);
        }
        private function addView():void
        {
            testContainer.addChild(new MockView());
        }
        private function build():void
        {
            outTf = new TextField();
            addChild(outTf);
            outTf.defaultTextFormat = new TextFormat("Verdana", 12);
            outTf.width = stage.stageWidth;
            outTf.height = stage.stageHeight;
            new TextLog().out = out;
            new XMLLog().out = out;
        }
        private function out(value:*):void
        {
            outTf.appendText(String(value) + "\n");
        }
    }
}