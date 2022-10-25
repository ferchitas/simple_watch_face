import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Weather;
import Toybox.Time;
import Toybox.Time.Gregorian;
using Toybox.ActivityMonitor as Act;
using Toybox.Activity as Acty;

class simple_watch_faceView extends WatchUi.WatchFace {

    private var timeView as Text?;
    private var lemonBigFont = null;
    private var lemonSmallFont = null;
    private var lemonTinyFont = null;

    private var batteryGreenIcon as BitmapType;
    private var batteryOrangeIcon as BitmapType;
    private var batteryRedIcon as BitmapType;
    private var heartIcon as BitmapType;
    private var conditionTextArea as TextArea;

    function initialize() {

        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        
        setLayout(Rez.Layouts.WatchFace(dc));
        lemonBigFont = WatchUi.loadResource(Rez.Fonts.lemonbig);
        lemonSmallFont = WatchUi.loadResource(Rez.Fonts.lemonsmall);
        lemonTinyFont =  WatchUi.loadResource(Rez.Fonts.lemontiny);
        timeView = View.findDrawableById("time") as Text;

        batteryGreenIcon = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.batteryGreen,
            :locX=>dc.getWidth() * 0.52,
            :locY=>dc.getHeight() * 0.9,
            :justification=>"Graphics.TEXT_JUSTIFY_RIGHT"
        });

        batteryOrangeIcon = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.batteryOrange,
            :locX=>dc.getWidth() * 0.52,
            :locY=>dc.getHeight() * 0.9,
            :justification=>"Graphics.TEXT_JUSTIFY_RIGHT"
        });

        batteryRedIcon = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.batteryRed,
            :locX=>dc.getWidth() * 0.52,
            :locY=>dc.getHeight() * 0.9,
            :justification=>"Graphics.TEXT_JUSTIFY_RIGHT"
        });

        heartIcon = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.heartIcon,
            :locX=>dc.getWidth() * 0.72,
            :locY=>dc.getHeight() * 0.48,
            :justification=>"Graphics.TEXT_JUSTIFY_RIGHT"
        });

        conditionTextArea = new WatchUi.TextArea({
            :color=>Graphics.COLOR_WHITE,
            :font=>lemonTinyFont,
            :locX =>dc.getWidth() * 0.24,
            :locY=>dc.getHeight() * 0.60,
            :width=>160,
            :height=>80
        });
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        
        var today = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var hours = today.hour.toString();
        var mins = today.min.toString();

        if(today.hour < 10) {

            hours = "0" + hours;
        }

        if(today.min < 10) {

            mins = "0" + mins;
        }
        var timeString = Lang.format(
            "$1$:$2$",
            [
                hours,
                mins
            ]
        );
        timeView.setText(timeString);
        timeView.setFont(lemonBigFont);

        var dateString = Lang.format(
            "$1$, $2$ $3$",
            [
                today.day_of_week,
                today.day,
                today.month
            ]
        );

        var dateView = View.findDrawableById("date") as Text;
        dateView.setText(dateString);
        dateView.setFont(lemonSmallFont);

        var wea = Weather.getCurrentConditions().observationLocationPosition;

        var sunset = Weather.getSunset(wea, Time.now());
        var sunsetView = View.findDrawableById("sunset") as Text;
        var sunsetTime = Gregorian.utcInfo(sunset, Time.FORMAT_MEDIUM);
        var sunsetStringTime = SunView.getSunsetTime();
        sunsetView.setText(sunsetStringTime);
        sunsetView.setFont(lemonSmallFont);

        var sunrise = Weather.getSunrise(wea, Time.now());
        var sunriseView = View.findDrawableById("sunrise") as Text;
        var sunriseTime = Gregorian.utcInfo(sunrise, Time.FORMAT_MEDIUM);
        var sunriseStringTime = SunView.getSunriseTime();
        sunriseView.setText(sunriseStringTime);
        sunriseView.setFont(lemonSmallFont);

        if(Weather != null && Weather.getCurrentConditions() != null) {

            var temperature = "--";
            if(Weather.getCurrentConditions().temperature != null) {

                temperature = Weather.getCurrentConditions().temperature;
                var temperatureView = View.findDrawableById("temperature") as Text;
                temperatureView.setText(temperature.toString());
                temperatureView.setFont(lemonSmallFont);
            }
            var temperatureDegreeView = View.findDrawableById("temperatureDegree") as Text;
            temperatureDegreeView.setText("C");
            temperatureDegreeView.setFont(lemonTinyFont);
        }

        var activityMonitorInfo = ActivityMonitor.getInfo();
        var stepGoal = activityMonitorInfo.stepGoal.format("%02d");
        var stepGoalView = View.findDrawableById("stepGoal") as Text;
        stepGoalView.setText(stepGoal);
        stepGoalView.setFont(lemonSmallFont);

        var steps = activityMonitorInfo.steps.format("%02d");
        var stepsView = View.findDrawableById("steps") as Text;
        stepsView.setText(steps);
        stepsView.setFont(lemonSmallFont);

        var heartRate = "--";
        if (Act has :getHeartRateHistory) {

            heartRate = Activity.getActivityInfo().currentHeartRate;
            if(heartRate == null) {

                var HRH = Act.getHeartRateHistory(1, true);
                var HRS = HRH.next();
                if(HRS != null && HRS.heartRate != Act.INVALID_HR_SAMPLE){
                
                    heartRate = HRS.heartRate;
                }
            }  
            if(heartRate != null) {

                heartRate = heartRate.toString();
            }
        }
        var heartRateView = View.findDrawableById("heartRate") as Text;
        heartRateView.setText(heartRate);
        heartRateView.setFont(lemonSmallFont);
        
        var battery = System.getSystemStats().battery;
        var batteryStr = battery.format("%02d");
        var batteryView = View.findDrawableById("battery") as Text;
        batteryView.setText(batteryStr);
        batteryView.setFont(lemonSmallFont);
        
        
        View.onUpdate(dc);
        heartIcon.draw(dc);

        var condition = WeatherConditionUtils.getWeatherCondition(-1);
        if(Weather != null && Weather.getCurrentConditions() != null) {
            if(Weather.getCurrentConditions().condition != null) {

                condition = WeatherConditionUtils.
                    getWeatherCondition(Weather.getCurrentConditions().condition);
                conditionTextArea.setText(condition);
                conditionTextArea.draw(dc);
            }
        }

        if(battery >= 50) {

            batteryGreenIcon.draw(dc);

        } else if(battery < 50 && battery >= 15) {

            batteryOrangeIcon.draw(dc);

        } else {

            batteryRedIcon.draw(dc);
        }
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
