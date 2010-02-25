package
{
    import asunit4.ui.MinimalRunnerUI;

    import support.UIImpersonator;

    import org.robotlegs.utilities.lasyMediator.AllTests;
    /**
     * @author eidiot
     */
    public class LazyMediatorTestRunner extends MinimalRunnerUI
    {
        public function LazyMediatorTestRunner()
        {
            UIImpersonator.initialize(stage);
            run(AllTests);
        }
    }
}
