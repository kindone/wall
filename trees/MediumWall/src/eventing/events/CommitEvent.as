package eventing.events
{
import eventing.eventdispatchers.IEventDispatcher;

public class CommitEvent extends Event implements ICommitEvent
{
	public static const COMMIT:String = "commit";
	
	public function CommitEvent(dispatcher:IEventDispatcher)
	{
		super(dispatcher, COMMIT);
	}
}
}