package eventing.events
{
	import eventing.eventdispatchers.IEventDispatcher;

	public class CloseEvent extends Event
	{
		public static const CLOSE:String = "close";
		
		public function CloseEvent(dispatcher:IEventDispatcher)
		{
			super(dispatcher, CLOSE);
		}
	}
}