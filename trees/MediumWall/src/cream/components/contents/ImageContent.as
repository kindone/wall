package cream.components.contents
{
	import cream.components.buttons.Button;
	import cream.eventing.eventdispatchers.IClickEventDispatcher;
	import cream.eventing.events.ClickEvent;
	import cream.storages.IXMLizable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.core.IVisualElement;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	import spark.components.BorderContainer;

	public class ImageContent extends Content implements IImageContent
	{
		private var imageContainer:BorderContainer = new BorderContainer();
		private var bitmapData:BitmapData;
		private var convertedBitmapData:String;
		//private static const THUMB_WIDTH:uint = 300; // 크기 조절시 필요
		//private static const THUMB_HEIGHT:uint = 300;
		
		override protected function get visualElement():IVisualElement { return imageContainer; }
		
		public function ImageContent()
		{
			super();
			
			//imageContainer.percentWidth = 100;
			//imageContainer.percentHeight = 30;
			imageContainer.setStyle("borderAlpha", 0);

			imageContainer.width = 0;
			imageContainer.height = 0;
			
		}
		
		public function drawImage(imageBitmapData:BitmapData):void {
			bitmapData = imageBitmapData;
			//var matrix:Matrix = new Matrix();
			//matrix.scale(THUMB_WIDTH/bitmapData.width, THUMB_HEIGHT/bitmapData.height); // 크기 조절할 때 필요
			imageContainer.graphics.clear();
			imageContainer.graphics.beginBitmapFill(bitmapData, null, false);	//크기조절시 null->matrix
			imageContainer.graphics.drawRect(0, 0, bitmapData.width, bitmapData.height);
			imageContainer.graphics.endFill();
		}
		
		/**
		 * 	<content>
		 * 		<image image="...">
		 * 	</content>
		 */ 
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			if(bitmapData != null) {
				var imageXML:XML = <image/>;
				if(!convertedBitmapData) {
					convertedBitmapData = convertBitmaptoString(bitmapData)
				}
				imageXML.@image = convertedBitmapData;
				xml.appendChild(imageXML);
				trace("imageContent toXML");
			}
			return xml;
		}
		
		private static function convertBitmaptoString( bitmapData:BitmapData):String {
			if(!bitmapData)
				return null;

			var encoder : Base64Encoder = new Base64Encoder;
			encoder.encodeBytes(encodeBitmapData(bitmapData) , 0 ,encodeBitmapData(bitmapData).length);
			return encoder.toString();
		}
		private static function encodeBitmapData(bmp:BitmapData):ByteArray {
			var bytes:ByteArray = bmp.getPixels(bmp.rect);
			bytes.writeShort(bmp.width);   
			bytes.writeShort(bmp.height);   
			bytes.writeBoolean(bmp.transparent);   
			bytes.compress();   
			return bytes;   
		}
		private static function convertStringtoBitmap( string:String ):BitmapData {
			if(!string)
				return null;

			var decoder : Base64Decoder = new Base64Decoder;
			decoder.decode(string);
			var bitmapBA : ByteArray = decoder.toByteArray();
			bitmapBA.uncompress();
			return decodeBitmapData(bitmapBA);
		}
		private static function decodeBitmapData( data:ByteArray ):BitmapData
		{
			data.position = data.length - 1;   
			var transparent:Boolean = data.readBoolean();   
			data.position = data.length - 3;   
			var height:int = data.readShort();   
			data.position = data.length - 5;   
			var width:int = data.readShort();   
			data.position = 0;   
			var datas:ByteArray = new ByteArray();             
			data.readBytes(datas,0,data.length - 5);   
			var bmp:BitmapData = new BitmapData(width,height,transparent,0);   
			bmp.setPixels(new Rectangle(0,0,width,height),datas);   
			return bmp;   
		}

		override public function fromXML(xml:XML):IXMLizable {
			var imagexml:XML = xml.image[0];
			var savedBitmapData:BitmapData = convertStringtoBitmap(imagexml.@image);
			drawImage(savedBitmapData);
			trace("imageContent fromXML");
			return this;
		}
		public function getBitmapData():BitmapData {
			return bitmapData;
		}
	}
}