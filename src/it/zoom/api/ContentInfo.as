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
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const TRUE:String = "true"

    private static const ID:String = "id"
    private static const URL:String = "url"
    private static const READY:String = "ready"
    private static const FAILED:String = "failed"
    private static const PROGRESS:String = "progress"
    private static const SHARE_URL:String = "shareUrl"
    private static const EMBED_HTML:String = "embedHtml"
    private static const TITLE:String = "title"
    private static const ATTRIBUTION_TEXT:String = "attributionText"
    private static const ATTRIBUTION_URL:String = "attributionUrl"
    private static const DZI:String = "dzi"

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
     *
     *  Creates a new ContentInfo from XML.
     */
    public static function fromXML(xml:XML):ContentInfo
    {
        var id:String = xml.child(ID)
        var url:String = xml.child(URL)
        var ready:Boolean = xml.child(READY) == TRUE
        var failed:Boolean = xml.child(FAILED) == TRUE
        var progress:Number = parseFloat(xml.child(PROGRESS))
        var shareURL:String = xml.child(SHARE_URL)
        var embedHTML:String = xml.child(EMBED_HTML)
        var title:String = xml.hasOwnProperty(TITLE) ? xml.child(TITLE) : null
        var attributionText:String = xml.hasOwnProperty(ATTRIBUTION_TEXT) ?
            xml.child(ATTRIBUTION_TEXT) : null
        var attributionURL:String = xml.hasOwnProperty(ATTRIBUTION_URL) ?
            xml.child(ATTRIBUTION_URL) : null
        var dzi:DZIInfo = xml.hasOwnProperty(DZI) ?
            DZIInfo.fromXML(xml.child(DZI)[0]) : null

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
     *  Indicates the Zoom.it ID of this content.
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
     *  Indicates the original URL of this content.
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
     *  Indicates the whether this content has been finished processing.
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
     *  Indicates the whether processing of this content has failed.
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
     *  Indicates the processing progress of this content. Valid values are 0 (not processed) to 1 (fully processed).
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
     *  Indicates the URL at which this content is viewable on the Zoom.it service.
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
     *  Indicates the HTML code for embedding this content.
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
     *  Indicates the title of this content.
     *  The value is <code>null</code> if no title has been set.
     *
     *  @default null
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
     *  Indicates the attribution of this content.
     *  The value is <code>null</code> if no attribution has been set.
     *
     *  @default null
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
     *  Indicates the attribution URL of this content.
     *  The value is <code>null</code> if no attribution URL has been set.
     *
     *  @default null
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
     *  Indicates the associated Deep Zoom image info of this content.
     *  The value is <code>null</code> if no Deep Zoom image info has been associated.
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

    /**
     *  @inheritDoc
     */
    public function toString():String
    {
        return formatClassToString(this, "id", "url", "ready",
            "failed", "progress", "shareURL", "embedHTML", "title",
            "attributionText", "attributionURL", "dzi")
    }
}

}
