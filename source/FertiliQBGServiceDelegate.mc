using Toybox.Background;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;
using Toybox.SensorHistory;

(:background)
class FertiliQBGServiceDelegate extends Sys.ServiceDelegate {
	
	var fourHours = Gregorian.duration({:hours => 4});
	
	function initialize() {
		Sys.ServiceDelegate.initialize();
	}
	
	function onWakeTime() {
		Sys.println("onWakeTime");
		
		var minHR = -1;
		var minTemp = -1;
		
		var hrSum = 0;
		var hrCount = 0;
	    if (Toybox has :SensorHistory) {
	    	if (SensorHistory has :getHeartRateHistory) {
		        minHR = SensorHistory.getHeartRateHistory({:period => fourHours}).getMin();
	        }
	        if (SensorHistory has :getTemperatureHistory) {
	        	minTemp = SensorHistory.getTemperatureHistory({:period => fourHours}).getMin();
	        	
		        if (Sys.getDeviceSettings().temperatureUnits == Sys.UNIT_STATUTE) {
	        		minTemp = minTemp * 1.8 + 32;
        		}
	        }
	    }
	    
	    Sys.println("Min HR: " + minHR);
	    Sys.println("Min Temp: " + minTemp);
	    
	    Background.exit({"hr" => minHR, "temp" => minTemp});
	}
}