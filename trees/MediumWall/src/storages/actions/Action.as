package storages.actions
{
import storages.actions.IAction;

public class Action implements IAction
{
	public var type:String;
	public var args:Array;
	public function Action(type:String, args:Array)
	{
		this.type = type;
		this.args = args;
	}
}
}