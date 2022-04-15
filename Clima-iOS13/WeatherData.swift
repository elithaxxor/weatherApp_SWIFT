

// parse json to str

import Foundation

struct WeatherData: Codable {
//    var coord: String
//    var weather: [Weather]
//    var temp: String
//    var humidity: String
//    var temp_min: String
//    var temp_max: String
//    var main: Main
//    var wind: String
//    var clouds: String
//    var timezone: String
//    var city: String
//    var name: String // city
//

    let name: String
    let main: Main
    let weather: [Weather]
}

// to access subarray of json
struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}


