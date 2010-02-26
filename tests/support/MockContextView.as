package support
{
    import org.robotlegs.utilities.lasyMediator.LasyMediatorActivator;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class MockContextView extends Sprite
    {
        public function MockContextView()
        {
            super();
            new LasyMediatorActivator(this);
        }
    }
}