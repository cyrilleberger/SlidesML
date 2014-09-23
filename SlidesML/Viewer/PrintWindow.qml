import QtQuick 2.0
import QtQuick.Window 2.0
import org.slidesml.print 1.0

Window {
  id: root
  width: 800
  height: 600
  property Component presentation
  property Printer printer: Printer
  {
    window: root
    orientation: Printer.Landscape
  }
  signal printFinished()

  Loader
  {
    id: presentationCurrent
    sourceComponent: root.presentation
    width: parent.width
    height: 600 * (width / 800)
    onItemChanged:
    {
      item.videosEnabled             = false
      item.animationsEnabled = false
//      item.currentSlideIndex
    }
  }
  Timer
  {
    id: printTimer
    repeat: true
    interval: 1000
    onTriggered: {
      printer.printWindow()
      if(presentationCurrent.item.currentSlideIndex === presentationCurrent.item.slides.length - 1)
      {
        root.visible = false
        printTimer.stop()
        printer.endPrinting()
        root.printFinished()
      } else {
        printer.newPage()
        ++presentationCurrent.item.currentSlideIndex;
      }
    }
  }

  function startPrinting()
  {
    visible = true
    printer.beginPrinting()
    printTimer.start()
  }
  function setEfficientMode(v)
  {
    if(v)
    {
      printer.mode = Printer.EFFICIENT
    }
  }
}