package components.elements
{
import components.elements.interfaces.IContent;
import mx.controls.Image;

public class ImageContent extends Image implements IContent
{
	public function ImageContent(url:String)
	{
		this.percentHeight = this.percentWidth = 100;
	}
	
	public function toXML():XML  {
		return <image/>;
	}
}
}