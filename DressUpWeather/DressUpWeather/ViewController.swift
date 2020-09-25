//
//  ViewController.swift
//  DressUpWeather
//
//  Created by Kacper on 24/09/2020.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var descriptLbl: UILabel!
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
            if let dsc = weatherDescription {
                descriptLbl.text = dsc
            } else {
                descriptLbl.text = "unknown"
            }
            setupBackground(weatherDsc: weatherDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        weatherDescription = nil
        temperature = nil
        loadWeather()
    }
    
    func setupCamera() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height-50)
        previewLayer.zPosition = -1
        previewLayer.videoGravity = .resizeAspect
        view.layer.addSublayer(previewLayer)

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    func setupBackground(weatherDsc: String?) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 20 || hour <= 6 {
            view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.25, alpha: 1.0)
            return
        }
        
        switch weatherDsc {
        case "clear sky":
            view.backgroundColor = UIColor(red: 0, green: 0.6471, blue: 1, alpha: 1.0)
        case "few clouds":
            view.backgroundColor = UIColor(red: 0.3294, green: 0.7647, blue: 1, alpha: 1.0)
        case "scattered clouds":
            view.backgroundColor = UIColor(red: 0.3765, green: 0.7373, blue: 0.9176, alpha: 1.0)
        case "broken clouds":
            view.backgroundColor = UIColor(red: 0.349, green: 0.498, blue: 0.8196, alpha: 1.0)
        case "shower rain":
            view.backgroundColor = UIColor(red: 0.1451, green: 0.6549, blue: 0.8078, alpha: 1.0)
        case "rain":
            view.backgroundColor = UIColor(red: 0.2314, green: 0.4824, blue: 0.6078, alpha: 1.0)
        default:
            view.backgroundColor = .lightGray
        }
            
    }
    
    func loadWeather() {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=e4aefc24741504690052445e9b81243d") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any] else { return }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String) ?? "unknown"
                    DispatchQueue.main.async { [weak self] in
                        self?.temperature = temp - 273
                        self?.weatherDescription = description
                    }
                } catch {
                    print("We had an error retriving the weather")
                }
            }
        }
        task.resume()
        
    }


}

