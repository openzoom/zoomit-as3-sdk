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

public class ResultEvent extends Event
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

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

    public function get request():AsyncRequest
    {
        return _request
    }

    /**
     *  @private
     */
    private var _result:*

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
     *  @inheritDoc
     */
    override public function clone():Event
    {
        return new ResultEvent(type, bubbles, cancelable, request, result)
    }

    /**
     *  @inheritDoc
     */
    override public function toString():String
    {
        return formatToString("ResultEvent", "type", "bubbles", "cancelable", "request", "result")
    }
}

}
