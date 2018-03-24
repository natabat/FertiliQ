using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class FertiliQMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }
    
    function onMenuItem(item) {
    	if (item == :logMenstruation) {
    		Sys.println("I menstruated!");
    	} else if (item == :logOvulation) {
    		Sys.println("I ovulated!");
    	} else if (item == :logInsemination) {
    		Sys.println("I was inseminated!");
    	}
    }
}