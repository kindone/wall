package components
{
import spark.components.Application;
import spark.components.WindowedApplication;

public interface IToplevelComponent
{
	function addToApplication(app:Application):void;
	function removeFromApplication(app:Application = null):void;
}
}