//
//  ViewController.swift
//  MorningGlory
//
//  Created by Shashwat Panda on 07/11/22.
//

import UIKit
import CoreLocation


class ViewController: UIViewController{
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    let url = URL(string: "https://quotable.io/random?maxLength=30")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: currentDate)
        dateLabel.text = dateString
        
        //Quote API Call
       
        URLSession.shared.fetchData(at: url) { result in
            DispatchQueue.main.async {
                
                self.quoteLabel.text = QuoteModel.quote
                self.authorLabel.text = "~ " + QuoteModel.author
                
            }
            
        }
        
    }

   //Quote API refresh
    
    @IBAction func refresh(_ sender: UIButton) {
        URLSession.shared.fetchData(at: url) { result in
            DispatchQueue.main.async {
                
                self.quoteLabel.text = QuoteModel.quote
                self.authorLabel.text = "~ " + QuoteModel.author
                
            }
            
        }
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func alarmPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAlarm", sender: self)
    }
}
//MARK: - WeatherManagerDelegate


extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
        
    }
    
}
//MARK: - CLLocationManagerDelegate


extension ViewController: CLLocationManagerDelegate {
        
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

