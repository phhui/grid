package controls.grid
{
	
	import core.ResUrl;
	import core.evnet.EventMgr;
	import core.evnet.FrameEvent;
	import core.evnet.FriendListEvent;
	import core.evnet.SceneEvent;
	import core.manager.ProxyMgr;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import module.FrameName;
	import module.scene.role.RoleP;
	
	import utils.MoveAuto;

	public class MenuList
	{
		static private var d:DataList;
		static private var inited:Boolean=false;
		static private var itemList:Array;
		static private var type:int=0;
		static private var contact:Function;
		static private var uid:String;
		public function MenuList()
		{
		}
		/**
		 *显示列表 
		 * @param stage 显示容器
		 * @param callBack回调方法，参数Object {id:0,label:"查看资料"}... [0,"查看资料"],[1,"发起聊天"],[2,"组建关系"],[3,"加为好友"],[4,"解除关系"],[5,"删除好友"],[6,"加入黑名单"],[7,"送礼"]
		 * @param type 显示类别 0陌生人  1好友  2家人
		 * 
		 */		
		static public function show(stage:Object,userId:String,callBack:Function=null,_type:int=0):void{
			var mid:String=(ProxyMgr.Inst.GetPxy(RoleP) as RoleP).meID.toString();
			if(mid==userId)return;
			uid=userId;
			type=_type;
			contact=callBack;
			if(!inited)init();
			stage.addChild(d);
			d.addEventListener(GridEvent.itemClick,itemChange);
			MoveAuto.move(d);//不需要则直接删除
		}
		static public function remove():void{
			if(d.parent)d.parent.removeChild(d);
			d.removeEventListener(GridEvent.itemClick,itemChange);
		}
		static private function init():void{
			list();
			d=new DataList(20,1);
			d.bindData(getList(),MenuItem);
			inited=true;
		}
		
		static private function itemChange(e:GridEvent):void
		{
			var mid:String=(ProxyMgr.Inst.GetPxy(RoleP) as RoleP).meID.toString();
			if(contact!=null)contact(e.data);
			switch(e.data.id){
				case 0://进入TA家
					EventMgr.Inst.send(FrameEvent.FRAME_OPEN, { strName:FrameName.OUTDOOR, objData: { serID:uid } } );
					break;
				case 1://查看对方资料
					navigateToURL(new URLRequest(ResUrl.getWebUrl("web_lookUser")+uid));
					break;
				case 2://打声招呼
					EventMgr.Inst.send(SceneEvent.HELLO, uid);
					break;
				case 3://组建家庭
					EventMgr.Inst.send(FrameEvent.FRAME_OPEN, { strName:FrameName.RELATION, objData:{oth_uid:uid,uid:mid} } );
					break;
				case 4://加为好友
					EventMgr.Inst.send(FriendListEvent.ADD_FRIEND, {oth_uid:uid});
					break;
			}
			remove();
		}
		static private function getList():Array{
			var arr:Array=[];
			var n:int=itemList.length;
			var s:String="";
			for(var i:int=0;i<n;i++){
				s=","+itemList[i]["type"]+",";
				if(s.indexOf(","+type.toString()+",")!=-1){
					arr.push(itemList[i]);
				}
			}
			return arr;
		}
		static private function list():void{
			itemList=[];
			itemList.push({id:0,label:"进入TA家",type:"0,1,2"});
			itemList.push({id:1,label:"查看资料",type:"0,1,2"});
			itemList.push({id:2,label:"打声招呼",type:"0,1,2"});
			itemList.push({id:3,label:"组建家庭",type:"0,1"});
			itemList.push({id:4,label:"加为好友",type:"0"});
		}
	}
}