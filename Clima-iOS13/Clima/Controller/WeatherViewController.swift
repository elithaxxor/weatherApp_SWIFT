
// bd4c482d20066dd548cbf9d7bb74b4fc


import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherLogicDelegate {
 
    // models obj init
    var runLogic = weatherLogic()
    var queriedWeather = ""

    
    //[START MVC] 1 (async update to refresh weather)
    func weatherUpdater(weather: WeatherModels ){
        DispatchQueue.main.async {
        print(weather.temp)
            print("conditional view: \(weather.conditionName)")
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    func failException(error: Error) {
        print(error)
    }
    
    //[END MVC] 1
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var textInputbox: UITextField! // use .delegate to retrieve memory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textInputbox.delegate = self // for the 'return' or 'go' btn on keyboard
        runLogic.delegate = self
        
    }

    
    @IBAction func searchTapped(_ sender: UIButton) {
        print("Search Btn: \(sender.isTouchInside)")
        print(textInputbox.text!)
        textInputbox.endEditing(true)
    }
    
    // [start of delegate methods]
    func textfieldReturn (_ textField: UITextField) -> Bool {
        var textResponse = textInputbox.text
        print(textResponse!)
        return true
    }
    
    func textFieldDidEnd (_ textField: UITextField) {
        print("clearing text field")
        if let city = textInputbox.text{
            runLogic.fetchWeather(cityName: city)
        };textInputbox.text = ""
        
        
    }
    func textFieldShouldEnd (_ textField: UITextField) -> Bool {
        print("checking if textfield is empty")
        if textInputbox.text != "" {
            return true
        } else {
            textInputbox.placeholder = "city or zip"
            return false }
    }
    // [end of delegate methods]
    
    
    

    
    @IBAction func topTextField(_ sender: UITextField) {
        print(textInputbox.text!)
        runLogic.fetchWeather(cityName:textInputbox.text!)
    }
    
}

