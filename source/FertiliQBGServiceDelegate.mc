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
		
		var avgHR = 0;
		var avgTemp = 0;
	    if (Toybox has :SensorHistory) {
	    	if (SensorHistory has :getHeartRateHistory) {
	    		var hrHist = SensorHistory.getHeartRateHistory({:period => fourHours});
		        minHR = hrHist.getMin();
		        avgHR = getAverage(hrHist);
	        }
	        if (SensorHistory has :getTemperatureHistory) {
	        	var tempHist = SensorHistory.getTemperatureHistory({:period => fourHours});
	        	minTemp = tempHist.getMin();
	        	avgTemp = getAverage(tempHist);
	        	
		        if (Sys.getDeviceSettings().temperatureUnits == Sys.UNIT_STATUTE) {
	        		minTemp = toF(minTemp);
	        		avgTemp = toF(avgTemp);
        		}
	        }
	    }
	    
	    Sys.println("Min HR: " + minHR);
	    Sys.println("Avg HR: " + avgHR);
	    Sys.println("Min Temp: " + minTemp);
	    Sys.println("Avg Temp: " + avgTemp);
	    
	    Background.exit({"hr" => avgHR, "temp" => avgTemp});
	}
	
	function getAverage(hist) {
		var samp = hist.next();
		var sum = 0;
		var count = 0;
		while (samp != null) {
			if (samp.data != null) {
				sum += samp.data;
				count++;
			}
			samp = hist.next();
		}
		
		return sum/count;
	}
	
	function toF(c) {
		return c * 1.8 + 32;
	}
}