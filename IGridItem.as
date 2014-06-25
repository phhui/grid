package controls.grid
{
	public interface IGridItem
	{
		function bindData(data:Object):void;
		function change(bl:Boolean):void;
		function getData():Object;
		function resetData():void;
		function clearData():void;
			
	}
}