////////////////////////////////////////////////////////////////////////////////
//
//   Copyright 2010 Daniel Gasienica <daniel@gasienica.ch>
//
//   Licensed under the Apache License, Version 2.0 (the "License")
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

import it.zoom.api.events.FaultEvent;
import it.zoom.api.events.ResultEvent;
import it.zoom.api.utils.formatClassToString;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched when an AsyncRequest returns successfully.
 *  @eventType it.zoom.api.events.ResultEvent.RESULT
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 */
[Event(type="it.zoom.api.events.ResultEvent", name="result")]

/**
 *  Dispatched when an AsyncRequest fails.
 *  @eventType it.zoom.api.events.FaultEvent.FAULT
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 */
[Event(type="it.zoom.api.events.FaultEvent", name="fault")]

/**
 *  The AsyncRequest class provides an abstraction of messaging for API call
 *  invocation. An AsyncRequest allows multiple requests to be made on a remote
 *  destination and will dispatch either a ResultEvent when the remote request is
 *  completed or a FaultEvent if the request fails.
 */
public final class AsyncRequest implements IEventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
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
        dispatcher = new EventDispatcher(this)
        request = new URLRequest(url)
        loader = new URLLoader(request)

        loader.addEventListener(Event.COMPLETE,
            loader_completeHandler, false, 0, true)
        loader.addEventListener(IOErrorEvent.IO_ERROR,
            loader_errorHandler, false, 0, true)
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
            loader_errorHandler, false, 0, true)

        // FIXME Do we need to make the call asynchronous?
        // setTimeout(start, 0)
        start()
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private var dispatcher:EventDispatcher

    /**
     *  @private
     */
    private var loader:URLLoader

    /**
     *  @private
     */
    private var request:URLRequest

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    /**
     *  Holds arbitrary context data for this request.
     */
    public var context:*

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Cancels the asynchronous request if possible.
     */
    public function cancel():void
    {
        dispose()
    }

    //--------------------------------------------------------------------------
    //
    //  Methods: Object
    //
    //--------------------------------------------------------------------------

    /**
     *  Returns the string representation of the specified object.
     */
    public function toString():String
    {
        return formatClassToString(this, "context")
    }

    //--------------------------------------------------------------------------
    //
    //  Methods: IDisposable
    //
    //--------------------------------------------------------------------------

    /**
     *  @inheritDoc
     */
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
    //  Methods: IEventDispatcher
    //
    //--------------------------------------------------------------------------

    // I didn't extend EventDispatcher because it provides us with
    // unnecessary additional event hints during code completion.
    // Composition avoids this.

    /**
     *  @inheritDoc
     */
    public function addEventListener(type:String,
                                     listener:Function,
                                     useCapture:Boolean=false,
                                     priority:int=0,
                                     useWeakReference:Boolean=false):void
    {
        dispatcher.addEventListener(type, listener, useCapture, priority)
    }

    /**
     *  @inheritDoc
     */
    public function dispatchEvent(event:Event):Boolean
    {
        return dispatcher.dispatchEvent(event)
    }

    /**
     *  @inheritDoc
     */
    public function hasEventListener(type:String):Boolean
    {
        return dispatcher.hasEventListener(type)
    }

    /**
     *  @inheritDoc
     */
    public function removeEventListener(type:String,
                                        listener:Function,
                                        useCapture:Boolean=false):void
    {
        dispatcher.removeEventListener(type, listener, useCapture)
    }

    /**
     *  @inheritDoc
     */
    public function willTrigger(type:String):Boolean
    {
        return dispatcher.willTrigger(type)
    }

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
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private function loader_completeHandler(event:Event):void
    {
        var event:Event
        var responseXML:XML = new XML(loader.data)

        // Try parsing
        var contentInfo:ContentInfo = parseContentInfo(responseXML)

        if (contentInfo)
            event = new ResultEvent(ResultEvent.RESULT, false, false, this, contentInfo)
        else
            event = new FaultEvent(FaultEvent.FAULT, false, false, this, parseError(responseXML))

        dispatchEvent(event)

        dispose()
    }

    /**
     *  @private
     */
    private function loader_errorHandler(event:Event):void
    {
        var faultEvent:FaultEvent = new FaultEvent(FaultEvent.FAULT, false, false, this, UNKNOWN_ERROR_MESSAGE)
        dispatchEvent(faultEvent)

        dispose()
    }
}

}
