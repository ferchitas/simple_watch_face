import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Weather;
import Toybox.Time;
import Toybox.Time.Gregorian;

class simple_watch_faceView extends WatchUi.WatchFace {


    function initialize() {
        WatchFace.initialize();

    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        var timeString = TimeUtil.getCurrentTime();
        // Update the view
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setColor(getApp().getProperty("ForegroundColor") as Number);
        view.setText(timeString);

        var wea = Weather.getCurrentConditions().observationLocationPosition;

        var sunset = Weather.getSunset(wea, Time.now());
        var sunsetView = View.findDrawableById("Sunset") as Text;
        var sunsetTime = Gregorian.utcInfo(sunset, Time.FORMAT_MEDIUM);
        var sunsetStringTime = SunView.getSunsetTime();
        sunsetView.setText(sunsetStringTime);

        var sunrise = Weather.getSunrise(wea, Time.now());
        var sunriseView = View.findDrawableById("Sunrise") as Text;
        var sunriseTime = Gregorian.utcInfo(sunrise, Time.FORMAT_MEDIUM);
        var sunriseStringTime = SunView.getSunriseTime();
        sunriseView.setText(sunriseStringTime);

        var battery = System.getSystemStats().battery.format("%02d");
        var batteryView = View.findDrawableById("Battery") as Text;
        batteryView.setText(battery);

        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLUE);
        dc.clear();

        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
