import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;

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

    public static function getDate() {

        var today = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        return Lang.format(
            "$1$, $2$ $3$",
            [
                today.day_of_week,
                today.day,
                today.month
            ]
        );
    }

    public static function getTime() as String {

        var today = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var hours = today.hour.toString();
        var mins = today.min.toString();

        if(today.hour < 10) {

            hours = "0" + hours;
        }

        if(today.min < 10) {

            mins = "0" + mins;
        }
        return Lang.format(
            "$1$:$2$",
            [
                hours,
                mins
            ]
        );
    }
}