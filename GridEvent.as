package controls.grid
{
	import flash.events.Event;
	
	public class GridEvent extends Event
	{
		static public const itemClick:String="GridItemClick";
		public var data:Object;
		public function GridEvent(type:String,param:Object=null)
		{
			super(type);
			data=param;
		}
	}
}