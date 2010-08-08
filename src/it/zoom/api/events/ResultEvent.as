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
package it.zoom.api.events
{

import flash.events.Event;

import it.zoom.api.AsyncRequest;

/**
 *  The event that indicates an AsyncRequest has successfully returned a result.
 */
public class ResultEvent extends Event
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     * The RESULT event type.
     *
     * <p>The properties of the event object have the following values:</p>
     * <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>true, preventDefault()
     *       from the associated token's responder.result method will prevent
     *       the service or operation from dispatching this event</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *       event listener that handles the event. For example, if you use
     *       <code>myButton.addEventListener()</code> to register an event listener,
     *       myButton is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>message</code></td><td> The Message associated with this event.</td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
     *     <tr><td><code>result</code></td><td>Result that the RPC call returns.</td></tr>
     *     <tr><td><code>token</code></td><td>The token that represents the indiviudal call
     *     to the method. Used in the asynchronous completion token pattern.</td></tr>
     *  </table>
     *
     *  @eventType result
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     */
    public static const RESULT:String = "result"

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function ResultEvent(type:String,
                                bubbles:Boolean=false,
                                cancelable:Boolean=false,
                                request:AsyncRequest=null,
                                result:*=undefined)
    {
        super(type, bubbles, cancelable)

        _request = request
        _result = result
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private var _request:AsyncRequest

    /**
     *  The request associated with this event.
     */
    public function get request():AsyncRequest
    {
        return _request
    }

    /**
     *  @private
     */
    private var _result:*

    /**
     *  Result that the request returns.
     */
    public function get result():*
    {
        return _result
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods: Event
    //
    //--------------------------------------------------------------------------

    /**
     *  Returns a string that contains all the properties of the FaultEvent object.
     */
    override public function clone():Event
    {
        return new ResultEvent(type, bubbles, cancelable, request, result)
    }

    /**
     *  Returns the string representation of the specified object.
     */
    override public function toString():String
    {
        return formatToString("ResultEvent", "type", "bubbles", "cancelable", "request", "result")
    }
}

}
