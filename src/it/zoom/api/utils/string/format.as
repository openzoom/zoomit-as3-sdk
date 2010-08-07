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
package it.zoom.api.utils.string
{

/**
 *  The format function replaces each format item in a specified string with the
 *  text equivalent of a corresponding object's value.
 */
public function format(string:String, ...args):String
{
	var result:String = string
	
	for (var i:int = 0; i < args.length; i++)
		result = result.replace("{" + i + "}", args[i])
	
	return result
}

}
