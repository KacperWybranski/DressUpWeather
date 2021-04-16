//
//  ViewController.swift
//  DressUpWeather
//
//  Created by Kacper on 24/09/2020.
//

import UIKit
import CoreLocation
import CoreML

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var descriptLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var backgroundImage: BackgroundImage!
    @IBOutlet weak var outfitImage: OutfitImage!
    @IBOutlet weak var outfitImageSec: OutfitImage!
    @IBOutlet weak var recommendOutfitLabel: UILabel!
    
    var temperature: Int? = nil
    var weatherDescription: String? = nil {
        didSet {
            backgroundImage.setupBackground(weatherDsc: weatherDescription)
        }
    }
    var weatherDtlDscrpt: String? = nil
    
    var locationManager: CLLocationManager?
    var currentLocation = CLLocation(latitude: 35, longitude: 139)
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherDescription = nil
        temperature = nil
            
        locationLbl.adjustsFontSizeToFitWidth = true
        
        setupLocation()
        
        outfitImage.alpha = 0.0
        outfitImageSec.alpha = 0.0
        degreeLbl.alpha = 0.0
        descriptLbl.alpha = 0.0
        recommendOutfitLabel.alpha = 0.0
    }
    
    func loadWeather() {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(currentLocation.coordinate.latitude)&lon=\(currentLocation.coordinate.longitude)&appid=e4aefc24741504690052445e9b81243d") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any] else { return }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["main"] as? String) ?? "unknown"
                    let dtlDescription = (weatherDetails.first?["description"] as? String) ?? "unknown"
                    DispatchQueue.main.async { [weak self] in
                        self?.weatherDataLoaded(temp: temp - 273, description: description, detail: dtlDescription)
                    }
                } catch {
                    print("We had an error retriving the weather")
                }
            }
        }
        task.resume()
        
    }
    
    func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            if let location = manager.location {
                let lat = Double(round(100*location.coordinate.latitude)/100)
                let long = Double(round(100*location.coordinate.longitude)/100)
                currentLocation = CLLocation(latitude: lat, longitude: long)
                loadLocationName()
                loadWeather()
            }
        }
    }
    
    func loadLocationName() {
        //temporary name until proper name is loaded
        locationLbl.text = "[\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)]"
        
        //loading proper name
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                if let name = placemark.locality {
                    print(name)
                    locationLbl.text = name
                }
            } else {
                print("no matching location found")
            }
        }
        
    }
    
    func recommendOutfit() {
        guard let temp = temperature, let wthr = weatherDescription else { return }
        
        let model: OutfitRecommender
        
        do {
            let config = MLModelConfiguration()
            model = try OutfitRecommender.init(configuration: config)
        } catch {
            print(error)
            return
        }
        
        let title: String
        let message: String
        
        let input = OutfitRecommenderInput(temperature: Double(temp), weather: wthr)
        
        do {
            let prediction = try model.prediction(input: input)
            
            let results = prediction.rsltProbability
            
            let sortedDict = results.sorted {
                return $0.value > $1.value
            }
            
            outfitImage.drawOutfit(sortedDict[0].key)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
                self?.outfitImageSec.drawOutfit(sortedDict[1].key)
            }
            
        } catch {
            title = "Error"
            message = "There was an error with finding proper outfit."
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        outfitImage.fadeOut()
        outfitImageSec.fadeOut()
        labelsFadeOut()
        setupLocation()
    }
    
    func weatherDataLoaded(temp: Int?, description: String?, detail: String?) {
        temperature = temp
        weatherDescription = description
        weatherDtlDscrpt = detail
        
        if let temp = temp {
            degreeLbl.text = "\(temp)°C"
        } else {
            degreeLbl.text = "xx°C"
        }
        
        if let dsc = description {
            descriptLbl.text = dsc.capitalized
        } else {
            descriptLbl.text = "unknown"
        }
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.degreeLbl.alpha = 1.0
            self?.descriptLbl.alpha = 1.0
            self?.recommendOutfitLabel.alpha = 1.0
        }
        
        recommendOutfit()
    }
    
    func labelsFadeOut() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.degreeLbl.alpha = 0.0
            self?.descriptLbl.alpha = 0.0
            self?.recommendOutfitLabel.alpha = 0.0
        }
    }
}

