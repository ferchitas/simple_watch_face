import Toybox.System;
import Toybox.Lang;

class TimeUtil {

    static function getCurrentTime() as String {

        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var timeFormat = getBasicTimeFormat();
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = getBasicTimeFormatMilitary();
                hours = hours.format("%02d");
            }
        }
        return Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
    }

    static function getBasicTimeFormat() as String {

        return "$1$:$2$";
    }

    static function getBasicTimeFormatMilitary() as String {

        return "$1$$2$";
    }
}