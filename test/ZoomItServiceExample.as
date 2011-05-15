////////////////////////////////////////////////////////////////////////////////
//
//   Copyright 2010 Daniel Gasienica <daniel@gasienica.ch>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package 
{

import flash.display.Sprite;

import it.zoom.api.AsyncRequest;
import it.zoom.api.ContentInfo;
import it.zoom.api.IAsyncRequest;
import it.zoom.api.ZoomItService;
import it.zoom.api.events.FaultEvent;
import it.zoom.api.events.ResultEvent;

/**
 *  @exampleText Simple example to demonstrate the basic usage of ZoomItService
 **/
public class ZoomItServiceExample extends Sprite
{
    public function ZoomItServiceExample()
    {
        service = new ZoomItService()

        var request:IAsyncRequest = service.getContentInfoById("h")
        request.context = "I'm the successful request:"
        request.addEventListener(ResultEvent.RESULT,
            request_resultHandler, false, 0, true)
        request.addEventListener(FaultEvent.FAULT,
            request_faultHandler, false, 0, true)
            
        var faultyRequest:IAsyncRequest = service.getContentInfoById("101010")
        faultyRequest.context = "I'm the faulty request:"
        faultyRequest.addEventListener(ResultEvent.RESULT,
            request_resultHandler, false, 0, true)
        faultyRequest.addEventListener(FaultEvent.FAULT,
            request_faultHandler, false, 0, true)
    }
    
    private var service:ZoomItService
    
    private function request_resultHandler(event:ResultEvent):void
    {
        var content:ContentInfo = event.result as ContentInfo

        if (content)
            trace(event.request.context, content)
    }
    
    private function request_faultHandler(event:FaultEvent):void
    {
        trace(event.request.context, event.text)
    }
}

}
