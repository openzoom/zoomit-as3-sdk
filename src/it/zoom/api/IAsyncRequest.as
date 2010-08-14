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
import flash.events.IEventDispatcher;

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

//--------------------------------------
//  Excluded APIs
//--------------------------------------

[Exclude(name="activate", kind="event")]
[Exclude(name="deactivate", kind="event")]

/**
 *  The IAsyncRequest interface defines events, properties and methods of
 *  an abstraction of messaging for API call invocation.
 *  An IAsyncRequest allows multiple requests to be made on a remote
 *  destination and will dispatch either a ResultEvent when the remote request is
 *  completed or a FaultEvent if the request fails.
 */
public interface IAsyncRequest extends IEventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  context
    //----------------------------------

    /**
     *  Holds arbitrary context data for this request.
     */
    function get context():*
    function set context(value:*):void

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Stops the asynchronous request, if possible.
     */
    function stop():void
}

}
