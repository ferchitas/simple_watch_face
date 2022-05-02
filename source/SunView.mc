import Toybox.Weather;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Lang.*;
import Toybox.Time;


class SunView {

    static function getWeatherLocation() as Array {

        var result as Array = new Array[2];
        if(Weather.getCurrentConditions() != null &&
            Weather.getCurrentConditions().observationLocationPosition != null) {

            result = Weather.getCurrentConditions().observationLocationPosition;
        }
        return result;
    }
    
    static function getSunsetTime() as String {

        var result = "No data";
        var location as Array = getWeatherLocation();
        if(location != null) {
            var sunsetEpoch = Weather.getSunset(location , Time.now());
            var sunsetTime = Gregorian.utcInfo(sunsetEpoch, Time.FORMAT_MEDIUM);
            result = Lang.format(TimeUtil.getBasicTimeFormat(), [sunsetTime.hour , sunsetTime.min]);
        }
        return result;
    }

    static function getSunriseTime() as String {

        var result = "No data";
        var location = getWeatherLocation();
        if(location.size > 0) {
            var sunsetEpoch = Weather.getSunrise(location , Time.now());
            var sunsetTime = Gregorian.utcInfo(sunsetEpoch, Time.FORMAT_MEDIUM);
            result = Lang.format(TimeUtil.getBasicTimeFormat(), [sunsetTime.hour , sunsetTime.min]);
        }
        return result;
    }
}