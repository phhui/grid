格子控件，主要用于商城物品列表展示或背包显示等。
PQGrid.as主类
IGridItem.as接口
GItem.as子元件，实现IGridItem接口
/**
*格子列表组件 实例化
* @param rowNum 行数
* @param columnNum 列数
* @param spaceV 行间距
* @param spaceH 列间距
* @param direction 扩展方向(v/h)--超过1页是水平扩展还是垂直扩展
* public function PQGrid(rowNum:int,columnNum:int,spaceV:int=5,spaceH:int=5,direction:String="v")
*/

/**
*绑定数据 bindData
* @param data 数据源
* @param itemClass 格子类 Class
* public function bindData(data:Array, itemClass:Object):void
*/