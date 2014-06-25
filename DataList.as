package controls.grid
{
	public class DataList extends PQGrid
	{
		private var pageData:Array=[];
		private var pageNum:int=1;
		private var currentPage:int=1;
		private var itemC:Class;
		public function DataList(rowNum:int, spaceV:int=5)
		{
			super(rowNum, 1, spaceV, 5, "v");
		}
		/**
		*绑定数据 
		* @param data 数据源
		* @param itemClass 格子类 Class
		* 
		*/			
		override public function bindData(data:Array, itemClass:Object):void {
			reset();
			if(!data)return;
			var n:int = data.length;
			if(n<1)return;
			itemC=itemClass as Class;
			if(rowNum>data.length)rowNum=data.length;
			paging(data);
			createItem();
		}
		/**
		 *对数据进行分页 
		 * @param data
		 * 
		 */		
		private function paging(data:Array):void{
			var n:int=data.length;
			pageNum = Math.round(data.length / rowNum+0.5);
			var itemIndex:int=0;
			for(var i:int=0;i<pageNum;i++){
				pageData[i]=new Array();
				for(var j:int=0;j<rowNum;j++){
					if(j+i*rowNum+1>n)return;
					pageData[i].push(data[itemIndex]);
					itemIndex++;
				}
			}
		}
		private function createItem():void{
			if(!pageData[currentPage-1])return;
			reset();
			var iNum:int=pageData[currentPage-1].length-1;
			for (var i:int = 0; i < rowNum; i++) {
				if(i>iNum)return;
				if(item[i]==null)item[i]= new itemC();
				item[i].addEventListener(GridEvent.itemClick,itemClick);
				item[i].y = i>0?item[i-1].y+item[i-1].height + spaceV:0;
				this.addChild(item[i]);
				var iitem:IGridItem = item[i];
				if(!iitem)throw new Error("列表子项必需实现IGridItem接口");
				if(pageData[currentPage-1][i]!=null)iitem.bindData(pageData[currentPage-1][i]);
				else trace("第"+currentPage+"页数据，第"+i+"项为空!");
			}
		}
		public function lastPage():void{
			if(currentPage<2)return;
			currentPage--;
			createItem();
		}
		public function nextPage():void{
			if(currentPage>pageNum)return;
			currentPage++;
			createItem();
		}
		public function goPage(p:int):void{
			if(p<1||p>pageNum)return;
			currentPage=p;
			createItem();
		}
		private function reset():void{
			this.removeChildren();
			var n:int=item.length;
			for(var i:int=0;i<n;i++){
				item[i].resetData();
			}
		}
		override public function clear():void{
			while(item.length>0){
				item[0].clearData();
				item.shift().removeEventListener(GridEvent.itemClick,itemClick);
			}
			this.removeChildren();
			pageData=[];
			pageNum=1;
			currentPage=1;
			itemC=null;
		}
	}
}