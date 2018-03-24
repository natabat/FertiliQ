using Toybox.Application as App;
using Toybox.Background;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

var OS_DATA = "FertiliQData";
var bgData = {};

(:background)
class FertiliQApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    	if (Sys has :ServiceDelegate) {
    		Background.registerForWakeEvent();
		}
    }
       
    function getServiceDelegate() {
    	return [new FertiliQBGServiceDelegate()];
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new FertiliQView(), new FertiliQDelegate() ];
    }
    
    // handle background data
    function onBackgroundData(data) {
    	Sys.println("onBackgroundData: " + data);
    	bgData = data;
    	App.Storage.setValue(OS_DATA, data);
    	Ui.requestUpdate();
    }

}
