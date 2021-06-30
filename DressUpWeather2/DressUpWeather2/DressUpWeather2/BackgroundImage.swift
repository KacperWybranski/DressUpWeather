//
//  BackgroundImage.swift
//  DressUpWeather2
//
//  Created by Kacper on 12/03/2021.
//

import UIKit

class BackgroundImage: UIImageView {
    func setupBackground(weatherDsc: String?) {
        //loading view looks better when using superview instead of self.bounds
        guard let view = superview else { return }
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 19 || hour <= 6 {
            drawNightTheme()
            return
        } else {
            drawDayTheme(superview: view,dsc: weatherDsc)
            return
        }
    }
    
    func drawNightTheme() {
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        
        let img = renderer.image { ctx in
            
            //draw blue-black gradient
            let colorsSpace = CGColorSpaceCreateDeviceRGB()
            let colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor, UIColor(red: 0, green: 0.1, blue: 0.4, alpha: 1.0).cgColor]

            if let gradient = CGGradient(colorsSpace: colorsSpace, colors: colors as CFArray, locations: [0.0, 1.0]) {
                
                ctx.cgContext.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: self.bounds.height), options: [])
            }
            
            //draw stars
            let imgWidth = self.bounds.width
            let imgHeight = self.bounds.height
            
            for _ in 1...100 {
                let rect = CGRect(x: CGFloat.random(in: 0...imgWidth), y: CGFloat.random(in: 0...imgHeight), width: 3, height: 3)
                ctx.cgContext.setFillColor(UIColor(white: 1.0, alpha: CGFloat.random(in: 0...1.0)).cgColor)
                
                ctx.cgContext.addEllipse(in: rect)
                ctx.cgContext.drawPath(using: .fill)
            }
        }
        
        image = img
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.isHidden = false
        }
    }
    
    func drawDayTheme(superview view: UIView, dsc: String?) {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        
        let img = renderer.image { ctx in
            let colorsSpace = CGColorSpaceCreateDeviceRGB()
            var colors = [CGColor]()
            
            switch dsc {
            case "Clear":
                colors = [UIColor(red: 0, green: 0.65, blue: 1, alpha: 1.0).cgColor, UIColor(red: 0.5, green: 0.9, blue: 1, alpha: 1.0).cgColor]
            case "Clouds":
                colors = [UIColor(red: 0.4, green: 0.4, blue: 0.5, alpha: 1.0).cgColor, UIColor(red: 0.3, green: 0.7, blue: 0.8, alpha: 1.0).cgColor]
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
        
        image = img
        
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.isHidden = false
        }
    }
}
