package components
{
import spark.components.TextArea;
import components.interfaces.IContent;
import flash.events.FocusEvent;

public class TextContent extends TextArea implements IContent
{
	public function TextContent(text:String)
	{
		super();
		this.percentHeight = this.percentWidth = 100;
		this.text = text;
		this.tabFocusEnabled = false;
	}
	
	override public function initialize():void  {
		super.initialize();
		this.setStyle("borderVisible", false);
	}
	
	public function toXML():XML  {
		var xml:XML = <text>{this.text}</text>;
		return xml;
	}
}
}