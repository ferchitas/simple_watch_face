import Toybox.Weather;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Position;
import Toybox.Time;
import Toybox.Activity;
using Toybox.System;

class SunUtil {

    static function getLocation() as Position.Location or Null {
        if (Weather has :getCurrentConditions && Weather.getCurrentConditions() != null) {
            var cond = Weather.getCurrentConditions();
            if (cond.observationLocationPosition != null) {
                return cond.observationLocationPosition;
            }
        }

        var actInfo = Activity.getActivityInfo();
        if (actInfo != null && actInfo.currentLocation != null) {
            return actInfo.currentLocation;
        }

        return null;
    }

    static function getSunsetTime() as String {
        var loc = getLocation();
        if (loc == null) {
            return "--:--";
        }

        var sunsetMoment = Weather.getSunset(loc, Time.now());
        if (sunsetMoment == null) {
            return "--:--";
        }

        // Gregorian.info convierte automáticamente a hora local usando FORMAT_SHORT
        var sunsetGregorianTime = Gregorian.info(sunsetMoment, Time.FORMAT_SHORT);
        
        var hours = sunsetGregorianTime.hour;
        var mins = sunsetGregorianTime.min;

        return Lang.format("$1$:$2$", [hours.format("%02d"), mins.format("%02d")]);
    }

    static function getSunriseTime() as String {
        var loc = getLocation();
        if (loc == null) {
            return "--:--";
        }

        var sunriseMoment = Weather.getSunrise(loc, Time.now());
        if (sunriseMoment == null) {
            return "--:--";
        }

        var sunriseGregorianTime = Gregorian.info(sunriseMoment, Time.FORMAT_SHORT);
        
        var hours = sunriseGregorianTime.hour;
        var mins = sunriseGregorianTime.min;

        return Lang.format("$1$:$2$", [hours.format("%02d"), mins.format("%02d")]);
    }
}