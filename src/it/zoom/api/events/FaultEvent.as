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

import flash.events.ErrorEvent;
import flash.events.Event;

public final class FaultEvent extends ErrorEvent
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static const FAULT:String = "fault"

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function FaultEvent(type:String,
                               bubbles:Boolean=false,
                               cancelable:Boolean=false,
                               text:String="")
    {
        super(type, bubbles, cancelable, text)
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods: Event
    //
    //--------------------------------------------------------------------------

    override public function clone():Event
    {
        return new FaultEvent(type, bubbles, cancelable, text)
    }

    override public function toString():String
    {
        return formatToString("FaultEvent", "type", "bubbles", "cancelable", "text")
    }
}

}
