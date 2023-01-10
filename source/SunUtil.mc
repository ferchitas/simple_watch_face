import Toybox.Weather;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Lang.*;
import Toybox.Position;
import Toybox.Time;
using Toybox.System;
import Toybox.Activity;

class SunUtil {

    static function getWeatherLocation() as Position.Location {

        System.println("Entrando en getWeatherLocation.");
        var result as Array = null;
        if(Weather.getCurrentConditions() != null &&
            Weather.getCurrentConditions().observationLocationPosition != null) {
            System.println("Weather.getCurrentConditions().observationLocationPosition no es nulo.");
            var observationLocationPosition = Weather.getCurrentConditions().observationLocationPosition;
            System.println("Calculando nueva localizacion.");
            result = new Position.Location({
                :latitude => observationLocationPosition.toDegrees()[0],
                :longitude => observationLocationPosition.toDegrees()[1],
                :format => :degrees
            });
            System.println("Nueva localizacion calculada");
        }
        return result;
    }

    static function getLastLocation() as Position.Location {

        var curLoc = Activity.getActivityInfo().currentLocation;
        var result = null;
        if (curLoc != null) {
            result = new Position.Location({
                :latitude => curLoc.toDegrees()[0].toFloat(),
                :longitude => curLoc.toDegrees()[1].toFloat(),
                :format => :degrees
            });
        }
        return result;
    }
    
    static function getSunsetTime() as String {

        System.println("Entrando en getSunsetTime.");
        var result = "--:--";
        var lastLocation as Position.Location = getLastLocation();
        
        if(lastLocation != null) {
            System.println("Weather condition no es nulo.");
            var sunset = Weather.getSunset(lastLocation, Time.now());
            System.println("Fecha y hora obtenida.");
            var sunsetGregorianTime = Gregorian.info(sunset, Time.FORMAT_MEDIUM);
            System.println("Fecha y hora pasada a calendario gregoriano.");
            var hours = sunsetGregorianTime.hour;
            var mins = sunsetGregorianTime.min;
            var format = TimeUtil.getBasicTimeFormat();
            result = Lang.format(format, [hours, mins]);
            System.println("Hora pasada a string.");
        }
        return result;
    }

    static function getSunriseTime() as String {

        var result = "--:--";
        var lastLocation as Position.Location = getLastLocation();
        
        if(lastLocation != null) {
            System.println("Weather condition no es nulo.");
            var sunset = Weather.getSunrise(lastLocation, Time.now());
            System.println("Fecha y hora obtenida.");
            var sunsetGregorianTime = Gregorian.info(sunset, Time.FORMAT_MEDIUM);
            System.println("Fecha y hora pasada a calendario gregoriano.");
            var hours = sunsetGregorianTime.hour;
            var mins = sunsetGregorianTime.min;
            var format = TimeUtil.getBasicTimeFormat();
            result = Lang.format(format, [hours, mins]);
            System.println("Hora pasada a string.");
        }
        return result;
    }
}