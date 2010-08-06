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

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.setTimeout;

import it.zoom.api.events.FaultEvent;
import it.zoom.api.events.ResultEvent;

//--------------------------------------
//  Events
//--------------------------------------

[Event(type="it.zoom.api.events.ResultEvent", name="result")]
[Event(type="it.zoom.api.events.FaultEvent", name="fault")]

/**
 *  @author Daniel Gasienica
 */
public final class AsyncRequest extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const UNKNOWN_ERROR_MESSAGE:String = "Unknown error."

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *
     *  Constructor.
     */
    public function AsyncRequest(url:String)
    {
        request = new URLRequest(url)
        loader = new URLLoader(request)

        loader.addEventListener(Event.COMPLETE,
            loader_completeHandler, false, 0, true)
        loader.addEventListener(IOErrorEvent.IO_ERROR,
            loader_errorHandler, false, 0, true)
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
            loader_errorHandler, false, 0, true)

        // Make the call asynchronously
        setTimeout(start, 0)
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var loader:URLLoader
    private var request:URLRequest

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private function start():void
    {
        loader.load(request)
    }

    /**
     *  @private
     */
    private function parseContentInfo(responseXML:XML):ContentInfo
    {
        if (responseXML.hasOwnProperty("content"))
            return ContentInfo.fromXML(responseXML.content[0])

        return null
    }

    /**
     *  @private
     */
    private function parseError(responseXML:XML):String
    {
        if (responseXML.hasOwnProperty("error"))
            return responseXML.error[0].toString()

        return UNKNOWN_ERROR_MESSAGE
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function cancel():void
    {
        dispose()
    }

    //--------------------------------------------------------------------------
    //
    //  Methods: IDisposable
    //
    //--------------------------------------------------------------------------

    public function dispose():void
    {
        if (loader)
        {
            try
            {
                loader.close()
            }
            catch (error:Error)
            {
                // Do nothing
            }
            finally
            {
                loader.removeEventListener(Event.COMPLETE,
                    loader_completeHandler)
                loader.removeEventListener(IOErrorEvent.IO_ERROR,
                    loader_errorHandler)
                loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
                    loader_errorHandler)
                loader = null
                request = null
            }
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function loader_completeHandler(event:Event):void
    {
        var event:Event
        var responseXML:XML = new XML(loader.data)

        // Try parsing
        var contentInfo:ContentInfo = parseContentInfo(responseXML)

        if (contentInfo)
            event = new ResultEvent(ResultEvent.RESULT, false, false, contentInfo)
        else
            event = new FaultEvent(FaultEvent.FAULT, false, false, parseError(responseXML))

        dispatchEvent(event)

        dispose()
    }

    private function loader_errorHandler(event:Event):void
    {
        var faultEvent:FaultEvent = new FaultEvent(FaultEvent.FAULT, false, false, UNKNOWN_ERROR_MESSAGE)
        dispatchEvent(faultEvent)

        dispose()
    }
}

}
