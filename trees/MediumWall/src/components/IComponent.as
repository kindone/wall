package components
{
import flash.geom.Point;
import eventing.eventdispatchers.IDimensionChangeEventDispatcher;
import eventing.eventdispatchers.IFocusEventDispatcher;
import eventing.eventdispatchers.IExternalDimensionChangeEventDispatcher;

public interface IComponent extends IComposite, IDimensionChangeEventDispatcher, IFocusEventDispatcher, IExternalDimensionChangeEventDispatcher
{
	function get width():Number;
	function set width(val:Number):void;
	function get height():Number;
	function set height(val:Number):void;
	function resize(w:Number, h:Number):void;
	
	function globalToLocal(point:Point):Point;
	function localToGlobal(point:Point):Point;
}
}