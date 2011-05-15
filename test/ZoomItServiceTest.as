package 
{
import flash.display.Sprite;

import it.zoom.api.ContentInfo;
import it.zoom.api.IAsyncRequest;
import it.zoom.api.ZoomItService;
import it.zoom.api.events.FaultEvent;
import it.zoom.api.events.ResultEvent;

public class ZoomItServiceTest extends Sprite
{
    private static const RESULT_RESPONSE:String = '<response xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><status>200</status><statusText>OK</statusText><content><id>h</id><url>http://upload.wikimedia.org/wikipedia/commons/3/36/SeattleI5Skyline.jpg</url><ready>true</ready><failed>false</failed><progress>1</progress><shareUrl>http://zoom.it/h</shareUrl><embedHtml>&lt;script src="http://zoom.it/h.js?width=auto&amp;height=400px"&gt;&lt;/script&gt;</embedHtml><dzi><url>http://cache.zoom.it/content/h.dzi</url><width>4013</width><height>2405</height><tileSize>254</tileSize><tileOverlap>1</tileOverlap><tileFormat>jpg</tileFormat></dzi></content></response>'
    private static const FAULT_RESPONSE:String = '<response xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><status>404</status><statusText>Not Found</statusText><error>No content with ID: 999999</error></response>'
        
    public function ZoomItServiceTest()
    {
        var resultXML:XML = new XML(RESULT_RESPONSE)
        var contentInfo:ContentInfo = ContentInfo.fromXML(resultXML.content[0])
        trace(contentInfo)        
        
        service = new ZoomItService()
        var successfulRequest:IAsyncRequest = service.getContentInfoById("otf")
        successfulRequest.context = 1
        successfulRequest.addEventListener(ResultEvent.RESULT, call_resultEvent)
        successfulRequest.addEventListener(FaultEvent.FAULT, call_faultHandler)
            
        var unsuccessfulRequest:IAsyncRequest = service.getContentInfoByURL("http://gasi.ch/?r=0.7466482506133616")// + Math.random().toString())
        unsuccessfulRequest.addEventListener(ResultEvent.RESULT, call_resultEvent)
        unsuccessfulRequest.addEventListener(FaultEvent.FAULT, call_faultHandler)
    }
    
    private var service:ZoomItService
    
    private function call_resultEvent(event:ResultEvent):void
    {
        trace(event.result)
    }
        
    private function call_faultHandler(event:FaultEvent):void
    {
        trace(event.text)
    }
}

}
