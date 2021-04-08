//
//  BackgroundTheme.swift
//  DressUpWeather2
//
//  Created by Kacper on 09/03/2021.
//

import UIKit

class BackgroundTheme: UIImageView {
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
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.backgroundImage.image = img
            self?.backgroundImage.isHidden = false
        }
    }
}
