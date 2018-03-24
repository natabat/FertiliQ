using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

class FertiliQView extends Ui.View {

	var hrLabel;
	var tempLabel;
	
	var width;
	var height;
	
	var just = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;
	
    function initialize() {
        View.initialize();

	    var temp = App.Storage.getValue(OS_DATA);
        Sys.println(temp);
        bgData = temp;
    }

    // Load your resources here
    function onLayout(dc) {
        hrLabel = Ui.loadResource(Rez.Strings.hrLabel);
        tempLabel = Ui.loadResource(Rez.Strings.tempLabel);
        
        width = dc.getWidth();
        height = dc.getHeight();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        var hr = 0;
        var temp = 0;
        
        if (bgData != null) {
	        hr = bgData["hr"];
	        temp = bgData["temp"];
        }
       
		var print = "";
		if (hr == 0 && temp == 0) {
			print = "No data";
		}
		if (hr != 0) {
			print += Lang.format("$1$: $2$", [hrLabel, hr]);
			if (temp != 0) {
				print += "\n";
			}
		}       
		if (temp != 0) {
			print += Lang.format("$1$: $2$", [tempLabel, temp.format("%.2f")]);
		}
        dc.drawText(width/2, height/2, Gfx.FONT_SMALL, print, just);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
