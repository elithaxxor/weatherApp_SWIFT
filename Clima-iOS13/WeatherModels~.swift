
import Foundation


struct WeatherModels {
//    var coord: String
//    var weather: [Weather]
//    var humidity: String
//    var temp_min: String
//    var temp_max: String
//    var main: Main
//    var wind: String
//    var clouds: String
//    var timezone: String
//    var city: String
    
    let temp: Double
    let name: String // city
    let weatherId: Int
    
    var tempString: String{
        return String(format:"%.1f", temp)
    }
    
    var conditionName: String {
        print("weather ID \(weatherId)")
        
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
}

