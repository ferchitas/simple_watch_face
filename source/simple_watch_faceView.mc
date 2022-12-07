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
using Toybox.System;

class simple_watch_faceView extends WatchUi.WatchFace {

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

        var width as Number = dc.getWidth() * 0.52;
        var height as Number = dc.getHeight() * 0.9;
        var justification as String = "Graphics.TEXT_JUSTIFY_RIGHT";

        batteryGreenIcon = createBitmap(dc, Rez.Drawables.batteryGreen, width, height, justification);
        batteryOrangeIcon = createBitmap(dc, Rez.Drawables.batteryOrange, width, height, justification);
        batteryRedIcon = createBitmap(dc, Rez.Drawables.batteryRed, width, height, justification);
        heartIcon = createBitmap(dc, Rez.Drawables.heartIcon, dc.getWidth() * 0.72, dc.getHeight() * 0.48, justification);

        conditionTextArea = new WatchUi.TextArea({
            :color=>Graphics.COLOR_WHITE,
            :font=>lemonTinyFont,
            :locX =>dc.getWidth() * 0.24,
            :locY=>dc.getHeight() * 0.60,
            :width=>160,
            :height=>80
        });
    }

    private function createBitmap(dc as Dc, 
        drawableId as Symbol, 
        width as Number, 
        height  as Number, 
        justification as String) as BitmapType {

        return new WatchUi.Bitmap({
            :rezId=>drawableId,
            :locX=>width,
            :locY=>height,
            :justification=>justification
        });
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        
        showTime();
        showDate();
        showSunset();
        showSunrise();
        showTemperature();
        showStepGoal();
        showSteps();
        showHeartRate();
        View.onUpdate(dc);
        heartIcon.draw(dc);
        showBattery(dc);
        showWeatherCondition(dc);
    }

    private function showTemperature() {

        var temperature = "--";
        if(Weather != null && Weather.getCurrentConditions() != null) {
            if(Weather.getCurrentConditions().temperature != null) {

                temperature = Weather.getCurrentConditions().temperature;
            }
        }
        var temperatureView = View.findDrawableById("temperature") as Text;
        temperatureView.setText(temperature.toString());
        temperatureView.setFont(lemonSmallFont);
        var temperatureDegreeView = View.findDrawableById("temperatureDegree") as Text;
        temperatureDegreeView.setText("C");
        temperatureDegreeView.setFont(lemonTinyFont);
    }

    private function showHeartRate() as Void {
        
        var heartRateView = View.findDrawableById("heartRate") as Text;
        heartRateView.setText(HeartRateUtil.getHeartRate());
        heartRateView.setFont(lemonSmallFont);
    }

    private function showTime() {

        var time as String = TimeUtil.getTime();
        var timeView = View.findDrawableById("time") as Text;
        timeView.setText(time);
        timeView.setFont(lemonBigFont);
    }

    private function showDate() {

        var date as String = TimeUtil.getDate();
        var dateView = View.findDrawableById("date") as Text;
        dateView.setText(date);
        dateView.setFont(lemonSmallFont);
    }

    private function showSunset() {

        System.println("Entrando en showSunset.");
        var sunsetView = View.findDrawableById("sunset") as Text;
        sunsetView.setText(SunUtil.getSunsetTime());
        sunsetView.setFont(lemonSmallFont);
    }

    private function showSunrise() {

        var sunriseView = View.findDrawableById("sunrise") as Text;
        sunriseView.setText(SunUtil.getSunriseTime());
        sunriseView.setFont(lemonSmallFont);
    }

    private function showStepGoal() {

        var activityMonitorInfo = ActivityMonitor.getInfo();
        var stepGoal = activityMonitorInfo.stepGoal.format("%02d");
        var stepGoalView = View.findDrawableById("stepGoal") as Text;
        stepGoalView.setText(stepGoal);
        stepGoalView.setFont(lemonSmallFont);
    }

    private function showSteps() {

        var activityMonitorInfo = ActivityMonitor.getInfo();
        var steps = activityMonitorInfo.steps.format("%02d");
        var stepsView = View.findDrawableById("steps") as Text;
        stepsView.setText(steps);
        stepsView.setFont(lemonSmallFont);
    }

    private function showBattery(dc as Dc) {

        var battery = System.getSystemStats().battery;
        var batteryStr = battery.format("%02d");
        var batteryView = View.findDrawableById("battery") as Text;
        batteryView.setText(batteryStr);
        batteryView.setFont(lemonSmallFont);

        if(battery >= 50) {

            batteryGreenIcon.draw(dc);

        } else if(battery < 50 && battery >= 15) {

            batteryOrangeIcon.draw(dc);

        } else {

            batteryRedIcon.draw(dc);
        }
    }

    private function showWeatherCondition(dc as Dc) {

        var condition = WeatherConditionUtils.getWeatherCondition(-1);
        if(Weather != null && Weather.getCurrentConditions() != null) {
            if(Weather.getCurrentConditions().condition != null) {

                condition = WeatherConditionUtils.
                    getWeatherCondition(Weather.getCurrentConditions().condition);
                conditionTextArea.setText(condition);
                conditionTextArea.draw(dc);
            }
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
