package support
{
    import org.robotlegs.utilities.lazy.LazyMediatorActivator;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class MockView extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function MockView()
        {
            super();
            new LazyMediatorActivator(this);
        }
    }
}