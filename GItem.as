package controls.grid
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author phhui
	 */
	public class GItem extends Sprite implements IGridItem
	{
		protected var id:int;
		protected var bg:Sprite;
		protected var overSkin:Sprite;
		protected var changeSkin:Sprite;
		protected var txt:TextField;
		protected var bgColor:uint=0x999999;
		protected var w:int=80;
		protected var h:int=25;
		protected var obj:Object;
		protected var inited:Boolean=false;
		protected var changed:Boolean=false;
		public function GItem(_w:int=80,_h:int=25){
			w=_w;
			h=_h;
			initUI();
		}
		public function bindData(data:Object):void{
			obj=data;
		}
		/**重置数据**/
		public function resetData():void{
			txt.htmlText="";
			txt.text="";
			change(false);
			obj=null;
		}
		/**释放自己**/
		public function clearData():void{
			removeListen();
			bg=null;
			changeSkin=null;
			txt=null;
			inited=false;
			if(this.parent)this.parent.removeChild(this);
		}
		public function change(bl:Boolean):void{
			if(!changeSkin)return;
			changeSkin.visible=bl;
			changed=bl;
		}
		public function isChanged():Boolean{
			return changed;
		}
		public function getData():Object{
			return obj;
		}
		protected function initUI():void{
			if(inited)return;
			createBg();
			createOverSkin();
			createChangeSkin();
			createTxt();
			listen();
			createUI();
		}		
		protected function createUI():void{
			//方便重写创建UI
		}
		protected function createBg():void{
			bg=new Sprite();
			bg.graphics.beginFill(bgColor,0.1);
			bg.graphics.drawRect(0,0,w,h);
			this.addChild(bg);
		}
		protected function createOverSkin():void{
			overSkin=new Sprite();
			overSkin.graphics.beginFill(bgColor,0.3);
			overSkin.graphics.drawRect(0,0,w,h);
			overSkin.mouseChildren=false;
			overSkin.mouseEnabled=false;
			overSkin.visible=false;
			this.addChild(overSkin);
		}
		/**创建选中状态样式**/
		protected function createChangeSkin():void{
			changeSkin=new Sprite();
			changeSkin.graphics.beginFill(bgColor,0.5);
			changeSkin.graphics.drawRect(0,0,w,h);
			changeSkin.visible=false;
			changeSkin.mouseChildren=false;
			this.addChild(changeSkin)
		}
		protected function createTxt():void{
			txt=new TextField();
			var tf:TextFormat=new TextFormat("微软雅黑",14);
			txt.defaultTextFormat=tf;
			txt.width=w;
			txt.height=h;
			txt.mouseEnabled=false;
			this.addChild(txt);
		}
		protected function listen():void{
			this.addEventListener(MouseEvent.CLICK,itemClick);
			this.addEventListener(MouseEvent.ROLL_OVER,showBg);
			this.addEventListener(MouseEvent.ROLL_OUT,hideBg);
		}
		protected function removeListen():void{
			this.removeEventListener(MouseEvent.CLICK,itemClick);
			this.removeEventListener(MouseEvent.ROLL_OVER,showBg);
			this.removeEventListener(MouseEvent.ROLL_OUT,hideBg);
		}
		protected function hideBg(e:MouseEvent):void{
			overSkin.visible=false;
		}
		protected function showBg(e:MouseEvent):void{
			overSkin.visible=true;
		}
		protected function itemClick(e:MouseEvent):void{
			this.dispatchEvent(new GridEvent(GridEvent.itemClick,obj));
		}
	}
}