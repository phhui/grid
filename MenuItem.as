package controls.grid
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class MenuItem extends GItem
	{
		public function MenuItem()
		{
			super();
		}
		override public function bindData(data:Object):void{
			id=data.id;
			obj=data;
			txt.htmlText=String(data.label);
		}
		override protected function createBg():void{
			bg=new Sprite();
			bg.graphics.beginFill(0xff9900,1);
			bg.graphics.drawRect(0,0,w,h);
			this.addChild(bg);
		}
	}
}