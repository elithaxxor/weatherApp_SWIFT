import Foundation
import CoreLocation


// [FOR MVC] 1
protocol WeatherLogicDelegate {
    func weatherUpdater(weather: WeatherModels)
    func failException(error: Error)
}

// [Init fetch logic / api call]
struct weatherLogic {
    
    // [FOR MVC] 2
    var delegate: WeatherLogicDelegate?
    

    
    // [Make Url + Key]
    let KEY = "&appid=bd4c482d20066dd548cbf9d7bb74b4fc"
    let BASEURL = "https://api.openweathermap.org/geo/1.0/direct?q="
    
    // [Input Cityname from User]
    func fetchWeather(cityName: String){
        let URL = BASEURL + cityName + KEY
        print("fetching: \(URL)")
        getSessions(FETCH: URL)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let URL = "\(BASEURL)&lat=\(latitude)&lon=\(longitude)\(KEY)"
        print("fetching: \(URL)")
        getSessions(FETCH: URL)
    }
    
    // [Start Sessions] (fetch)
    func getSessions(FETCH: String) {
        if let fetchUrl = URL(string: FETCH) {
            // create session obj
            let session = URLSession(configuration: .default)
            // init fetch
            let thread = session.dataTask(with: fetchUrl, completionHandler: threadHandler)
            print("Starting thread handle \(thread.progress)")
            thread.resume()
        }
    };
    func threadHandler(data: Data?, resp: URLResponse?, error: Error?){
        print("[data] \(data)")
        print("[resp] \(resp)")
        print("[error]")
        if error != nil {
            print("[error] \(error!)")
            self.delegate?.failException(error: error!)
            return
        }
        if let respData = data {
            if let dataStr = String(data: respData, encoding: .utf8) { // json to utf
                // print("non jsonified data \(dataStr!)")
                if let parsedWeather = self.parseJSON(weatherData: respData){
                    
                    // [For MVC] 3 (Delegate Call)
                    self.delegate?.weatherUpdater(weather: parsedWeather)
            }
        }
    }
        //let weatherVC = WeatherViewController()
        //print("parsed weather \(parsedWeather)")
        
    }
    func parseJSON(weatherData: Data) -> WeatherModels? {
        let jsonify = JSONDecoder()
        
        do {
            let jsonified = try jsonify.decode(WeatherData.self, from: weatherData)
            let id = jsonified.weather[0].id
            let temp = jsonified.main.temp
            let name = jsonified.name
            let weather = WeatherModels(temp: Double(id), name: name, weatherId: Int(temp))
            
            return weather

        } catch {
            print(error)
            return nil
            // [FOR MVC] Final
            delegate?.failException(error: error)
            return nil

            
    }
    }
    
}


