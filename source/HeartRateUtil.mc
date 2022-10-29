using Toybox.ActivityMonitor as Act;
using Toybox.Activity as Acty;

class HeartRateUtil {

    public static function getHeartRate() as String {

        var heartRate = "--";
        // if (Act has :getHeartRateHistory) {

        //     if(Acty has :getActivityInfo) {

        //     heartRate = Acty.getActivityInfo().currentHeartRate;
        //     if(heartRate == null) {

        //         var HRH = Act.getHeartRateHistory(1, true);
        //         var HRS = HRH.next();
        //         if(HRS != null && HRS.heartRate != Act.INVALID_HR_SAMPLE){
                
        //             heartRate = HRS.heartRate;
        //         }
        //     }  
        //     if(heartRate != null) {

        //         heartRate = heartRate.toString();
        //     }
        //     }
            
        // }
        if (Acty.getActivityInfo() != null && Acty.getActivityInfo().currentHeartRate != null) {
            heartRate = Acty.getActivityInfo().currentHeartRate;
            heartRate = heartRate.toString();
        }
        return heartRate;
    }
}