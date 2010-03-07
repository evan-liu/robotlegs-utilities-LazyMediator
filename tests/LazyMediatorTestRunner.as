package
{
    import support.UIImpersonator;

    import org.flexunit.internals.TraceListener;
    import org.flexunit.runner.FlexUnitCore;
    import org.robotlegs.utilities.lazy.AllTests;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class LazyMediatorTestRunner extends Sprite
    {
        public function LazyMediatorTestRunner()
        {
            UIImpersonator.initialize(stage);
            var flexunit:FlexUnitCore = new FlexUnitCore();
            flexunit.addListener(new TraceListener());
            flexunit.run(AllTests);
        }
    }
}