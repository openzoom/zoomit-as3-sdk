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

/**
 *  The IZoomItService interfaces defines the properties and methods
 *  of a service that provides access to the Zoom.it web API.
 *
 *  @see http://api.zoom.it
 */
public interface IZoomItService
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  endpoint
    //----------------------------------

    /**
     *  Indicates the API endpoint of the Zoom.it service without a trailing slash.
     *
     *  @default http://api.zoom.it/v1
     */
    function get endpoint():String
    function set endpoint(value:String):void

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Requests the info for the content given by the Zoom.it ID.
     */
    function getContentInfoById(id:String):IAsyncRequest

    /**
     *  Requests the info for the Zoom.it content created from the given URL.
     */
    function getContentInfoByURL(url:String):IAsyncRequest
}

}
