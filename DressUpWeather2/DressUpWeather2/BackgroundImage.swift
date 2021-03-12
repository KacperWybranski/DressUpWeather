//
//  BackgroundImage.swift
//  DressUpWeather2
//
//  Created by Kacper on 12/03/2021.
//

import UIKit

class BackgroundImage: UIImageView {
    
    func setupBackground(weatherDsc: String?) {
        guard let view = superview else { return }
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour >= 19 || hour <= 6 {
            drawNightTheme(view: view)
            return
        } else {
            drawDayTheme(view: view, dsc: weatherDsc)
            return
        }
    }
    
    func drawNightTheme(view: UIView) {
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
            self?.image = img
            self?.isHidden = false
        }
    }
    
    func drawDayTheme(view: UIView, dsc: String?) {
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
            self?.image = img
            self?.isHidden = false
        }
    }
}
