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
 *  The ContentInfo class represents a piece of content on Zoom.it.
 *
 *  @see http://zoom.it/pages/api/reference/v1/content
 */
public final class ContentInfo
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
    public function ContentInfo(id:String,
                                url:String,
                                ready:Boolean,
                                failed:Boolean,
                                progress:Number,
                                shareURL:String,
                                embedHTML:String,
                                title:String,
                                attributionText:String,
                                attributionURL:String,
                                dzi:DZIInfo=null)
    {
        _id = id
        _url = url
        _ready = ready
        _failed = failed
        _progress = progress
        _shareURL = shareURL
        _embedHTML = embedHTML
        _title = title
        _attributionText = attributionText
        _attributionURL = attributionURL
        _dzi = dzi
    }

    /**
     *  Constructor.
     */
    public static function fromXML(xml:XML):ContentInfo
    {
        var id:String = xml.id
        var url:String = xml.url
        var ready:Boolean = xml.ready == "true"
        var failed:Boolean = xml.failed == "true"
        var progress:Number = parseFloat(xml.progress)
        var shareURL:String = xml.shareURL
        var embedHTML:String = xml.embedHTML
        var title:String = xml.title
        var attributionText:String = xml.attributionText
        var attributionURL:String = xml.attributionURL
        var dzi:DZIInfo = null

        if (xml.hasOwnProperty("dzi"))
            dzi = DZIInfo.fromXML(xml.dzi[0])

        return new ContentInfo(id, url, ready, failed, progress, shareURL,
            embedHTML, title, attributionText, attributionURL, dzi)
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  id
    //----------------------------------

    /**
     *  @private
     */
    private var _id:String

    /**
     *
     */
    public function get id():String
    {
        return _id
    }

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
    //  ready
    //----------------------------------

    /**
     *  @private
     */
    private var _ready:Boolean

    /**
     *
     */
    public function get ready():Boolean
    {
        return _ready
    }

    //----------------------------------
    //  failed
    //----------------------------------

    /**
     *  @private
     */
    private var _failed:Boolean

    /**
     *
     */
    public function get failed():Boolean
    {
        return _failed
    }

    //----------------------------------
    //  progress
    //----------------------------------

    /**
     *  @private
     */
    private var _progress:Number

    /**
     *
     */
    public function get progress():Number
    {
        return _progress
    }

    //----------------------------------
    //  shareURL
    //----------------------------------

    /**
     *  @private
     */
    private var _shareURL:String

    /**
     *
     */
    public function get shareURL():String
    {
        return _shareURL
    }

    //----------------------------------
    //  embedHTML
    //----------------------------------

    /**
     *  @private
     */
    private var _embedHTML:String

    /**
     *
     */
    public function get embedHTML():String
    {
        return _embedHTML
    }

    //----------------------------------
    //  title
    //----------------------------------

    /**
     *  @private
     */
    private var _title:String

    /**
     *
     */
    public function get title():String
    {
        return _title
    }

    //----------------------------------
    //  attributionText
    //----------------------------------

    /**
     *  @private
     */
    private var _attributionText:String

    /**
     *
     */
    public function get attributionText():String
    {
        return _attributionText
    }

    //----------------------------------
    //  attributionURL
    //----------------------------------

    /**
     *  @private
     */
    private var _attributionURL:String

    /**
     *
     */
    public function get attributionURL():String
    {
        return _attributionURL
    }

    //----------------------------------
    //  dzi
    //----------------------------------

    /**
     *  @private
     */
    private var _dzi:DZIInfo

    /**
     *
     */
    public function get dzi():DZIInfo
    {
        return _dzi
    }

    //--------------------------------------------------------------------------
    //
    //  Debug
    //
    //--------------------------------------------------------------------------

    public function toString():String
    {
        return formatClassToString(this, "id", "url", "ready",
            "failed", "progress", "shareURL", "embedHTML", "title",
            "attributionText", "attributionURL", "dzi")
    }
}

}
