/* Copyright (c) 2014, Cyrille Berger <cberger@cberger.net>
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 */

import QtQuick 2.0
import StoryML 1.0
import StoryML.Components 1.0
import StoryML.Components.Lines 1.0

StoryElement
{
  id: root
  readonly property bool isSlice: true
  property Component layout: defaultLayout
  property Component  style: defaultStyle
  property int sliceNumber
  property variant notes: ""

  property SliceAnimation animation: SliceAnimation { frame: -1; parentItem: root}
  property SliceStyle  style_instance:  styleLoader.item
  property string title
  readyToTell: layoutLoader.status === Loader.Ready && layoutLoader.item && layoutLoader.item.readyToTell

  function object_to_list(_cls, _cis)
  {
    var obj = _cls
    if(_cis.length > 0)
    {
      obj = _cis
      if(_cls.length > 0)
      {
        console.log("Cannot set both content items and lines.")
      }
    }
    var list = []
    for(var k in obj)
    {
      list.push(obj[k])
    }
    return list
  }

  property variant content: object_to_list(contentLines, contentItems)
  property list<Item> contentItems
  property list<ContentLine> contentLines

  width:  800
  height: 600
  opacity: 0
  enabled: false
  z: -1

  Loader {
    id: styleLoader
    sourceComponent: style
    property alias __slice: root
    anchors.fill: parent
  }
  Loader {
    id: layoutLoader
    sourceComponent: layout
    property alias __slice: root
    anchors.fill: parent
    property SliceAnimation animation: SliceAnimation { parentItem: layoutLoader }
  }
}
