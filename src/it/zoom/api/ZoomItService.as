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

import it.zoom.api.utils.string.format;

/**
 *  The ZoomItService class provides access to the Zoom.it web API.
 *
 *  @includeExample ZoomItServiceExample.as
 * 
 *  @see http://api.zoom.it
 *
 */
public final class ZoomItService
{
	include "Version.as"

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     *  Specifies the default API endpoint for the Zoom.it service.
     */
    public static const ENDPOINT:String = "http://api.zoom.it/v1"

    /**
     *  @private
     */
    private static const CONTENT_RESOURCE:String = "content"

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function ZoomItService(endpoint:String=ENDPOINT)
    {
        this.endpoint = endpoint
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    /**
     *  Indicates the API endpoint of the Zoom.it service without a trailing slash.
     *
     *  @default http://api.zoom.it/v1
     */
    public var endpoint:String = ENDPOINT

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Requests the info for the content given by the Zoom.it ID.
     */
    public function getContentInfoById(id:String):AsyncRequest
    {
        // TODO Do we need to keep a reference because of the GC?
        // Experience and this article suggest no:
        // http://kuwamoto.org/2007/04/25/asynchronous-calls-explained/

        var requestURL:String = format("{0}/{1}/{2}?format=xml",
            endpoint, CONTENT_RESOURCE, id)
        return new AsyncRequest(requestURL)
    }

    /**
     *  Requests the info for the Zoom.it content created from the given URL.
     */
    public function getContentInfoByURL(url:String):AsyncRequest
    {
        // TODO Do we need to keep a reference because of the GC?
        // Experience and this article suggest no:
        // http://kuwamoto.org/2007/04/25/asynchronous-calls-explained/

        var requestURL:String = format("{0}/{1}/?url={2}&format=xml",
            endpoint, CONTENT_RESOURCE, encodeURIComponent(url))
        return new AsyncRequest(requestURL)
    }
}

}
