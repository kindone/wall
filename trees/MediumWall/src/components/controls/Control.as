package components.controls
{
import components.Component;
import components.ToplevelComponent;
import spark.components.Application;

public class Control extends ToplevelComponent implements IControl
{
	private var active:Boolean = false;
	
	public function Control()
	{
		super();
	}

	public function set x(val:Number):void
	{
		visualElement.x = val;	
	}
	
	public function set y(val:Number):void
	{
		visualElement.y = val;	
	}
	
	public function get isActive():Boolean
	{
		return active;
	}
	
	override public function addToApplication(app:Application):void
	{
		super.addToApplication(app);
		active = true;
	}
	
	override public function removeFromApplication(app:Application = null):void
	{
		super.removeFromApplication(app);
		active = false;
	}
	
}
}