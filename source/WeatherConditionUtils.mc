import Toybox.WatchUi;

class WeatherConditionUtils {

    public static function getWeatherCondition(number as Number) as String {

        var result;
        switch(number) {
            case 0:
                result = Rez.Strings.CONDITION_CLEAR;
            break;
            case 1:
                result = Rez.Strings.CONDITION_PARTLY_CLOUDY;
            break;
            case 2:
                result = Rez.Strings.CONDITION_MOSTLY_CLOUDY;
            break;
            case 3:
                result = Rez.Strings.CONDITION_RAIN;
            break;
            case 4:
                result = Rez.Strings.CONDITION_SNOW;
            break;
            case 5:
                result = Rez.Strings.CONDITION_WINDY;
            break;
            case 6:
                result = Rez.Strings.CONDITION_THUNDERSTORMS;
            break;
            case 7:
                result = Rez.Strings.CONDITION_WINTRY_MIX;
            break;
            case 8:
                result = Rez.Strings.CONDITION_FOG;
            break;
            case 9:
                result = Rez.Strings.CONDITION_HAZY;
            break;
            case 10:
                result = Rez.Strings.CONDITION_HAIL;
            break;
            case 11:
                result = Rez.Strings.CONDITION_SCATTERED_SHOWERS;
            break;
            case 12:
                result = Rez.Strings.CONDITION_SCATTERED_THUNDERSTORMS;
            break;
            case 13:
                result = Rez.Strings.CONDITION_UNKNOWN_PRECIPITATION;
            break;
            case 14:
                result = Rez.Strings.CONDITION_LIGHT_RAIN;
            break;
            case 15:
                result = Rez.Strings.CONDITION_HEAVY_RAIN;
            break;
            case 16:
                result = Rez.Strings.CONDITION_LIGHT_SNOW;
            break;
            case 17:
                result = Rez.Strings.CONDITION_HEAVY_SNOW;
            break;
            case 18:
                result = Rez.Strings.CONDITION_LIGHT_RAIN_SNOW;
            break;
            case 19:
                result = Rez.Strings.CONDITION_HEAVY_RAIN_SNOW;
            break;
            case 20:
                result = Rez.Strings.CONDITION_CLOUDY;
            break;
            case 21:
                result = Rez.Strings.CONDITION_RAIN_SNOW;
            break;
            case 22:
                result = Rez.Strings.CONDITION_PARTLY_CLEAR;
            break;
            case 23:
                result = Rez.Strings.CONDITION_MOSTLY_CLEAR;
            break;
            case 24:
                result = Rez.Strings.CONDITION_LIGHT_SHOWERS;
            break;
            case 25:
                result = Rez.Strings.CONDITION_SHOWERS;
            break;
            case 26:
                result = Rez.Strings.CONDITION_HEAVY_SHOWERS;
            break;
            case 27:
                result = Rez.Strings.CONDITION_CHANCE_OF_SHOWERS;
            break;
            case 28:
                result = Rez.Strings.CONDITION_CHANCE_OF_THUNDERSTORMS;
            break;
            case 29:
                result = Rez.Strings.CONDITION_MIST;
            break;
            case 30:
                result = Rez.Strings.CONDITION_DUST;
            break;
            case 31:
                result = Rez.Strings.CONDITION_DRIZZLE;
            break;
            case 32:
                result = Rez.Strings.CONDITION_TORNADO;
            break;
            case 33:
                result = Rez.Strings.CONDITION_SMOKE;
            break;
            case 34:
                result = Rez.Strings.CONDITION_ICE;
            break;
            case 35:
                result = Rez.Strings.CONDITION_SAND;
            break;
            case 36:
                result = Rez.Strings.CONDITION_SQUALL;
            break;
            case 37:
                result = Rez.Strings.CONDITION_SANDSTORM;
            break;
            case 38:
                result = Rez.Strings.CONDITION_VOLCANIC_ASH;
            break;
            case 39:
                result = Rez.Strings.CONDITION_HAZE;
            break;
            case 40:
                result = Rez.Strings.CONDITION_FAIR;
            break;
            case 41:
                result = Rez.Strings.CONDITION_HURRICANE;
            break;
            case 42:
                result = Rez.Strings.CONDITION_TROPICAL_STORM;
            break;
            case 43:
                result = Rez.Strings.CONDITION_CHANCE_OF_SNOW;
            break;
            case 44:
                result = Rez.Strings.CONDITION_CHANCE_OF_RAIN_SNOW;
            break;
            case 45:
                result = Rez.Strings.CONDITION_CLOUDY_CHANCE_OF_RAIN;
            break;
            case 46:
                result = Rez.Strings.CONDITION_CLOUDY_CHANCE_OF_SNOW;
            break;
            case 47:
                result = Rez.Strings.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW;
            break;
            case 48:
                result = Rez.Strings.CONDITION_FLURRIES;
            break;
            case 49:
                result = Rez.Strings.CONDITION_FREEZING_RAIN;
            break;
            case 50:
                result = Rez.Strings.CONDITION_SLEET;
            break;
            case 51:
                result = Rez.Strings.CONDITION_ICE_SNOW;
            break;
            case 52:
                result = Rez.Strings.CONDITION_THIN_CLOUDS;
            break;
            default:
                result = Rez.Strings.CONDITION_UNKNOWN;
            break;
        }
        return WatchUi.loadResource(result);
    }
}