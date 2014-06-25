package controls.grid
{	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PQGrid extends Sprite
	{
		private var _direction:String;
		private var _rowNum:int;
		private var _columnNum:int;
		private var _spaceV:int;
		private var _spaceH:int;
		private var _item:Array = [];
		/**
		 *格子列表组件 
		 * @param rowNum 行数
		 * @param columnNum 列数
		 * @param spaceV 行间距
		 * @param spaceH 列间距
		 * @param direction 扩展方向(v/h)--超过1页是水平扩展还是垂直扩展
		 * 
		 */		
		public function PQGrid(rowNum:int,columnNum:int,spaceV:int=5,spaceH:int=5,direction:String="v")
		{
			_rowNum = rowNum;
			_columnNum = columnNum;
			_spaceV = spaceV;
			_spaceH = spaceH;
			_direction = direction;
		}
		/**
		 *绑定数据 
		 * @param data 数据源
		 * @param itemClass 格子类 Class
		 * 
		 */		
		public function bindData(data:Array, itemClass:Object):void {
			var n:int = data.length;
			if(n<1)return;
			clear();
			var pNum:int = Math.round(n / (_rowNum * _columnNum)+0.5);
			var item:Class = Class(itemClass);
			var itemNum:int = 0;
			for (var p:int = 0; p < pNum;p++){
				for (var i:int = 0; i < _rowNum; i++) {
					for (var j:int = 0; j < _columnNum;j++){
						_item[itemNum]= new item();
						_item[itemNum].x = j % _columnNum * (_item[itemNum].width + _spaceH) + _spaceH;
						_item[itemNum].y = i * (_item[itemNum].height + _spaceV) + _spaceV;
						if (_direction == "v")_item[itemNum].y += p * (_rowNum * (_item[itemNum].height + _spaceV) + _spaceV);
						else _item[itemNum].x += p * (_columnNum * (_item[itemNum].width + _spaceH) + _spaceH);
						this.addChild(_item[itemNum]);
						_item[itemNum].addEventListener(GridEvent.itemClick,itemClick);
						var iitem:IGridItem = _item[itemNum];
						if(!iitem)throw new Error("列表项必需实现IGridItem接口");
						iitem.bindData(data[itemNum]);
						itemNum++;
						if (itemNum > n - 1)return;
					}
				}
			}
		}
		public function selectAll(selected:Boolean=true):void{
			var n:int=item.length;
			for(var i:int=0;i<n;i++){
				item[i].change(selected);
			}
		}
		public function getSelectItem():Array{
			var arr:Array=[];
			var n:int=item.length;
			for(var i:int=0;i<n;i++){
				if(item[i].isChanged())arr.push(item[i].getData());
			}
			return arr;	
		}
		public function itemClick(e:GridEvent):void{
			dispatchEvent(new GridEvent(GridEvent.itemClick,e.data));
			selectAll(false);
			e.target.change(true);
		}

		public function get item():Array
		{
			return _item;
		}

		public function get direction():String
		{
			return _direction;
		}

		public function set direction(value:String):void
		{
			_direction = value;
		}

		public function get rowNum():int
		{
			return _rowNum;
		}

		public function set rowNum(value:int):void
		{
			_rowNum = value;
		}

		public function get columnNum():int
		{
			return _columnNum;
		}

		public function set columnNum(value:int):void
		{
			_columnNum = value;
		}

		public function get spaceV():int
		{
			return _spaceV;
		}

		public function set spaceV(value:int):void
		{
			_spaceV = value;
		}

		public function get spaceH():int
		{
			return _spaceH;
		}

		public function set spaceH(value:int):void
		{
			_spaceH = value;
		}
		public function clear():void{
			while(_item.length>0){
				_item[0].clearData();
				_item.shift().removeEventListener(GridEvent.itemClick,itemClick);
			}
			this.removeChildren();
		}

	}
}