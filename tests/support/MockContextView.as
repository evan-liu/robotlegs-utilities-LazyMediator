package support
{
    import org.robotlegs.utilities.lazy.LazyMediatorActivator;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class MockContextView extends Sprite
    {
        public function MockContextView()
        {
            super();
            new LazyMediatorActivator(this);
        }
    }
}