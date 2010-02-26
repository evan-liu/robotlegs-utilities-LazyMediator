package support
{
    import org.robotlegs.utilities.lasyMediator.LasyMediatorActivator;

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
            new LasyMediatorActivator(this);
        }
    }
}