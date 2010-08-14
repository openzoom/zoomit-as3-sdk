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
package it.zoom.api
{
import it.zoom.api.events.FaultEvent;
import it.zoom.api.events.ResultEvent;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertStrictlyEquals;
import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

public class ZoomItServiceTest
{	
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const SERVICE_URL:String = "http://zoom.it/"
    private static const ROOT_URL:String = "http://openzoom.org/"
    private static const EXISTING_URL:String = ROOT_URL
    private static const EXISTING_URL_ID:String = "N44A"
    private static const EXISTING_URL_SHARE_URL = SERVICE_URL + EXISTING_URL_ID
    private static const NON_EXISTING_URL:String = ROOT_URL + "?t=" + new Date().time.toString() + "&r=" + Math.random().toString()

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var service:ZoomItService

    //--------------------------------------------------------------------------
    //
    //  Methods: Before & After
    //
    //--------------------------------------------------------------------------

    [Before]
    public function setUp():void
    {
        service = new ZoomItService()
    }

    [After]
    public function tearDown():void
    {
        service = null
    }

//    [BeforeClass]
//    public static function setUpBeforeClass():void
//    {
//    }
//
//    [AfterClass]
//    public static function tearDownAfterClass():void
//    {
//    }

    //--------------------------------------------------------------------------
    //
    //  Methods: Test
    //
    //--------------------------------------------------------------------------

    [Test(async, timeout="2000")]
    public function testGetContentByURLWithExistingURL():void
    {
        var request:AsyncRequest = request = service.getContentInfoByURL(EXISTING_URL)
        request.context = EXISTING_URL
        var resultHandler:Function = Async.asyncHandler(this, request_resultHandler, 2000)
        request.addEventListener(ResultEvent.RESULT, resultHandler, false, 0, true)
    }

    [Test(async, timeout="2000")]
    public function testGetContentByURLWithNonExistingURL():void
    {
        var request:AsyncRequest = request = service.getContentInfoByURL(NON_EXISTING_URL)
        request.context = NON_EXISTING_URL
        var resultHandler:Function = Async.asyncHandler(this, request_resultHandler, 2000)
        request.addEventListener(ResultEvent.RESULT, resultHandler, false, 0, true)
    }

    //--------------------------------------------------------------------------
    //
    //  Event Handlers
    //
    //--------------------------------------------------------------------------

    private function request_resultHandler(event:ResultEvent, passThroughData:Object):void
    {
        var request:AsyncRequest = event.request
        var context:* = request.context
        var result:* = event.result

        assertNotNull(context)
        assertNotNull(request)

        switch (context)
        {
            case EXISTING_URL:
                var content:ContentInfo = result as ContentInfo
                assertNotNull(content)
                assertTrue(content.ready)
                assertFalse(content.failed)
                assertStrictlyEquals(1, content.progress)
                assertEquals(EXISTING_URL_SHARE_URL, content.shareURL)
                assertEquals(EXISTING_URL, content.url)
                assertEquals(EXISTING_URL_ID, content.id)
                break

            case NON_EXISTING_URL:
                var content:ContentInfo = result as ContentInfo
                assertNotNull(content)
                assertFalse(content.ready)
                assertFalse(content.failed)
                assertTrue(content.progress < 1)
                assertEquals(NON_EXISTING_URL, content.url)
                break
        }
    }

    private function request_faultHandler(event:FaultEvent, passThroughData:Object):void
    {
    }
}

}
