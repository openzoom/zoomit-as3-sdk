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
	include "Version.as"

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const URL:String = "url"
    private static const WIDTH:String = "width"
    private static const HEIGHT:String = "height"
    private static const TILE_SIZE:String = "tileSize"
    private static const TILE_OVERLAP:String = "tileOverlap"
    private static const TILE_FORMAT:String = "tileFormat"

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
     *
     *  Creates a new DZIInfo instance from XML manifest.
     */
    public static function fromXML(xml:XML):DZIInfo
    {
        var url:String = xml.child(URL)
        var width:uint = xml.child(WIDTH)
        var height:uint = xml.child(HEIGHT)
        var tileSize:uint = xml.child(TILE_SIZE)
        var tileOverlap:uint = xml.child(TILE_OVERLAP)
        var tileFormat:String = xml.child(TILE_FORMAT)

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
     *  Indicates the URL of the Deep Zoom image manifest.
     *
     *  @see http://gasi.ch/blog/inside-deep-zoom-2
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
     *  Indicates the width of the Deep Zoom image, in pixels.
     *
     *  @see http://gasi.ch/blog/inside-deep-zoom-2
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
     *  Indicates the height of the Deep Zoom image, in pixels.
     *
     *  @see http://gasi.ch/blog/inside-deep-zoom-2
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
     *  Indicates the tile size of the Deep Zoom image, in pixels.
     *
     *  @see http://gasi.ch/blog/inside-deep-zoom-2
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
     *  Indicates the tile overlap of the Deep Zoom image, in pixels.
     *
     *  @see http://gasi.ch/blog/inside-deep-zoom-2
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
     *  Indicates the tile format of the Deep Zoom image.
     *  Deep Zoom (Silverlight), Seadragon Ajax (JavaScript) and Flash (OpenZoom)
     *  support either <code>jpg</code> or <code>png</code>.
     */
    public function get tileFormat():String
    {
        return _tileFormat
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
        // Returns the string representation of the specified object.
        return formatClassToString(this, "url", "width", "height", "tileSize",
            "tileOverlap", "tileFormat")
    }
}

}
