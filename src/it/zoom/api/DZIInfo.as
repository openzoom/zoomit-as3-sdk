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

import it.zoom.api.utils.formatClassToString;

/**
 *  The DZIInfo class represents a Microsoft Deep Zoom image.
 *
 *  @see http://zoom.it/pages/api/reference/v1/dzi
 *  @see http://msdn.microsoft.com/en-us/library/cc645077(v=VS.95).aspx
 *  @see http://msdn.microsoft.com/en-us/library/cc645050(v=VS.95).aspx
 */
public final class DZIInfo
{
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
    public function DZIInfo(url:String,
                            width:uint,
                            height:uint,
                            tileSize:uint,
                            tileOverlap:uint,
                            tileFormat:String)
    {
        _url = url
        _width = width
        _height = height
        _tileSize = tileSize
        _tileOverlap = tileOverlap
        _tileFormat = tileFormat
    }

    /**
     *  Constructor.
     */
    public static function fromXML(xml:XML):DZIInfo
    {
        var url:String = xml.url
        var width:uint = xml.width
        var height:uint = xml.height
        var tileSize:uint = xml.tileSize
        var tileOverlap:uint = xml.tileOverlap
        var tileFormat:String = xml.tileFormat

        return new DZIInfo(url, width, height, tileSize, tileOverlap, tileFormat)
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  url
    //----------------------------------

    /**
     *  @private
     */
    private var _url:String

    /**
     *
     */
    public function get url():String
    {
        return _url
    }

    //----------------------------------
    //  width
    //----------------------------------

    /**
     *  @private
     */
    private var _width:uint

    /**
     *
     */
    public function get width():uint
    {
        return _width
    }

    //----------------------------------
    //  height
    //----------------------------------

    /**
     *  @private
     */
    private var _height:uint

    /**
     *
     */
    public function get height():uint
    {
        return _height
    }

    //----------------------------------
    //  tileSize
    //----------------------------------

    /**
     *  @private
     */
    private var _tileSize:uint

    /**
     *
     */
    public function get tileSize():uint
    {
        return _tileSize
    }

    //----------------------------------
    //  tileOverlap
    //----------------------------------

    /**
     *  @private
     */
    private var _tileOverlap:uint

    /**
     *
     */
    public function get tileOverlap():uint
    {
        return _tileOverlap
    }

    //----------------------------------
    //  tileFormat
    //----------------------------------

    /**
     *  @private
     */
    private var _tileFormat:String

    /**
     *
     */
    public function get tileFormat():String
    {
        return _tileFormat
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods: Object
    //
    //--------------------------------------------------------------------------

    public function toString():String
    {
        return formatClassToString(this, "url", "width", "height", "tileSize",
            "tileOverlap", "tileFormat")
    }
}

}
