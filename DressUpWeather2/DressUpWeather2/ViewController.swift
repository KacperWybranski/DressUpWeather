//
//  ViewController.swift
//  DressUpWeather
//
//  Created by Kacper on 24/09/2020.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var descriptLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var temperature: Int? = nil {
        didSet {
            if let temp = temperature {
                degreeLbl.text = "\(temp)°C"
            } else {
                degreeLbl.text = "xx°C"
            }
        }
    }
    var weatherDescription: String? = nil {
        didSet {
            setupBackground(weatherDsc: weatherDescription)
        }
    }
    var weatherDtlDscrpt: String? = nil {
        didSet {
            if let dsc = weatherDtlDscrpt {
                descriptLbl.text = dsc.capitalized
            } else {
                descriptLbl.text = "unknown"
            }
        }
    }
    var locationManager: CLLocationManager?
    var currentLocation = CLLocation(latitude: 35, longitude: 139)
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDescription = nil
        temperature = nil
        loadWeather()
        
        locationLbl.adjustsFontSizeToFitWidth = true
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func setupBackground(weatherDsc: String?) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 19 || hour <= 6 {
            drawNightTheme()
            return
        } else {
            drawDayTheme(dsc: weatherDsc)
            return
        }
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
                        self?.temperature = temp - 273
                        self?.weatherDescription = description
                        self?.weatherDtlDscrpt = dtlDescription
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
        print(currentLocation)
        
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
    
    func drawNightTheme() {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        
        let img = renderer.image { ctx in
            let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            
            ctx.cgContext.setFillColor(UIColor(red: 0.5, green: 0, blue: 0.8, alpha: 1.0).cgColor)
            
            ctx.cgContext.addRect(rect)
            ctx.cgContext.drawPath(using: .fill)
            
            let colorsSpace = CGColorSpaceCreateDeviceRGB()
            let colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor, UIColor(red: 0, green: 0.1, blue: 0.4, alpha: 1.0).cgColor]

            if let gradient = CGGradient(colorsSpace: colorsSpace, colors: colors as CFArray, locations: [0.0, 1.0]) {
                
                ctx.cgContext.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: view.bounds.height), options: [])
            }
            
        }
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.backgroundImage.image = img
            self?.backgroundImage.isHidden = false
        }
    }
    
    func drawDayTheme(dsc: String?) {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        
        let img = renderer.image { ctx in
            let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            
            ctx.cgContext.setFillColor(UIColor(red: 0.5, green: 0, blue: 0.8, alpha: 1.0).cgColor)
            
            ctx.cgContext.addRect(rect)
            ctx.cgContext.drawPath(using: .fill)
            
            let colorsSpace = CGColorSpaceCreateDeviceRGB()
            var colors = [CGColor]()
            
            switch dsc {
            case "Clear":
                colors = [UIColor(red: 0, green: 0.65, blue: 1, alpha: 1.0).cgColor, UIColor(red: 0.5, green: 0.9, blue: 1, alpha: 1.0).cgColor]
            case "Clouds":
                colors = [UIColor(red: 0, green: 0.65, blue: 1, alpha: 1.0).cgColor, UIColor(red: 0.5, green: 0.9, blue: 1, alpha: 1.0).cgColor]
            case "Snow":
                colors = [UIColor(red: 0.76, green: 0.79, blue: 0.839, alpha: 1.0).cgColor, UIColor(red: 0.5, green: 0.9, blue: 1, alpha: 1.0).cgColor]
            case "Rain":
                colors = [UIColor(red: 0.2314, green: 0.4824, blue: 0.6078, alpha: 1.0).cgColor, UIColor(red: 0.5, green: 0.9, blue: 1, alpha: 1.0).cgColor]
            case "Drizzle":
                colors = [UIColor(red: 0.70, green: 0.79, blue: 0.89, alpha: 1.0).cgColor, UIColor(red: 0.5, green: 0.9, blue: 1, alpha: 1.0).cgColor]
            default:
                colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor]
            }

            if let gradient = CGGradient(colorsSpace: colorsSpace, colors: colors as CFArray, locations: [0.0, 1.0]) {
                
                ctx.cgContext.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: view.bounds.height), options: [])
            }
            
        }
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.backgroundImage.image = img
            self?.backgroundImage.isHidden = false
        }
    }
}

