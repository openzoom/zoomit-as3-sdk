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
package it.zoom.api.utils
{

import flash.utils.getQualifiedClassName;

public function formatClassToString(instance:Object, ...fields):String
{
    var qualifiedClassName:String = getQualifiedClassName(instance)
    var className:String = qualifiedClassName

    var parts:Array = qualifiedClassName.split("::")
    if (parts.length == 2)
        className = parts[1]

    var result:Array = ["[", className]

    for each (var field:String in fields)
    {
        var value:* = instance[field]
        result.push(" ")
        result.push(field)
        result.push("=")
        if (value is String)
            result.push("\"" + value + "\"")
        else
            result.push(String(value))
    }

    result.push("]")

    return result.join("")
}

}
