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

import flash.events.EventDispatcher;

import it.zoom.api.utils.string.format;

/**
 *  The ZoomItService class provides access to the Zoom.it web API.
 *
 *  @see http://api.zoom.it
 *
 *  @author Daniel Gasienica
 */
public final class ZoomItService extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const API_ENDPOINT:String = "http://api.zoom.it"
    private static const API_VERSION:String = "v1"

    private static const CONTENT_RESOURCE:String = "content"

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function ZoomItService()
    {
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getContentInfoById(id:String):AsyncRequest
    {
        var url:String = format("{0}/{1}/{2}/{3}?format=xml",
            API_ENDPOINT, API_VERSION, CONTENT_RESOURCE, id)
        return new AsyncRequest(url)
    }

    public function getContentInfoByURL(url:String):AsyncRequest
    {
        var url:String = format("{0}/{1}/{2}/?url={3}&format=xml",
            API_ENDPOINT, API_VERSION, CONTENT_RESOURCE, encodeURI(url))
        return new AsyncRequest(url)
    }
}

}
