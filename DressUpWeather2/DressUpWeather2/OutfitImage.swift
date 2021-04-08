//
//  OutfitImage.swift
//  DressUpWeather2
//
//  Created by Kacper on 18/03/2021.
//

import UIKit

class OutfitImage: UIImageView {
    func drawOutfit(_ outfit1: String) {
        
        //analazing outfit elements
        let outfitStringEdited = outfit1.replacingOccurrences(of: ",", with: "")
        let clothingElements = outfitStringEdited.split(separator: " ")
        let clothingOptions: [String: String] = ["hat": String(clothingElements[0]), "top": String(clothingElements[2]), "pants": String(clothingElements[4]), "jacket": String(clothingElements[6])]
        
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        
        let img = renderer.image { ctx in
            
            drawWhiteBackground(ctx: ctx)
            
            if clothingOptions["top"]! == "short" {
               drawShortShirt(ctx: ctx)
            } else if clothingOptions["top"]! == "long" {
                drawLongShirt(ctx: ctx)
            }
            
            if clothingOptions["pants"]! == "short" {
                drawShortPants(ctx: ctx)
            } else if clothingOptions["pants"]! == "long" {
                drawLongPants(ctx: ctx)
            }
                
                
        }
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.image = img
            self?.isHidden = false
        }
    }
    
    func drawWhiteBackground(ctx: UIGraphicsRendererContext) {
//        let rect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        ctx.cgContext.addRect(rect)
        ctx.cgContext.setFillColor(UIColor(white: 1.0, alpha: 0.1).cgColor)
        
        ctx.cgContext.move(to: CGPoint(x: 40, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 200, y: 0))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: 240, y: 40), control: CGPoint(x: 240, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 240, y: 200))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: 200, y: 240), control: CGPoint(x: 240, y: 240))
        ctx.cgContext.addLine(to: CGPoint(x: 40, y: 240))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: 0, y: 200), control: CGPoint(x: 0, y: 240))
        ctx.cgContext.addLine(to: CGPoint(x: 0, y: 40))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: 40, y: 0), control: CGPoint(x: 0, y: 0))
        
        ctx.cgContext.drawPath(using: .fill)
    }
    
    func drawShortShirt(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 45, y: 30)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addCurve(to: CGPoint(x: startPoint.x+30, y: startPoint.y), control1: CGPoint(x: startPoint.x, y: startPoint.y+15), control2: CGPoint(x: startPoint.x+30, y: startPoint.y+15))
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x + 30, y: startPoint.y))
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+8))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-30, y: startPoint.y+25))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-8, y: startPoint.y+35))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-8, y: startPoint.y+75))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+38, y: startPoint.y+75))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+38, y: startPoint.y+35))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+60, y: startPoint.y+25))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+8))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+30, y: startPoint.y))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    func drawLongShirt(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 45, y: 30)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addCurve(to: CGPoint(x: startPoint.x+30, y: startPoint.y), control1: CGPoint(x: startPoint.x, y: startPoint.y+15), control2: CGPoint(x: startPoint.x+30, y: startPoint.y+15))
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+30, y: startPoint.y))
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+8))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-30, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-8, y: startPoint.y+35))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-8, y: startPoint.y+75))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+38, y: startPoint.y+75))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+38, y: startPoint.y+35))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+60, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+8))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+30, y: startPoint.y))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    func drawShortPants(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 155, y: 40)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: startPoint)
        
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+50, y: startPoint.y))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+65, y: startPoint.y+50))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+30, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+25, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+20, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+50))
        ctx.cgContext.addLine(to: startPoint)
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+25, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+25, y: startPoint.y+7))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-4, y: startPoint.y+7))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+54, y: startPoint.y+7))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    func drawLongPants(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 160, y: 30)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: startPoint)
        
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+40, y: startPoint.y))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+48, y: startPoint.y+71))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+28, y: startPoint.y+73))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+20, y: startPoint.y+25))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+12, y: startPoint.y+73))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-8, y: startPoint.y+71))
        ctx.cgContext.addLine(to: startPoint)
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+20, y: startPoint.y+25))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+20, y: startPoint.y+5))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+41, y: startPoint.y+5))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+20, y: startPoint.y+5))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-1, y: startPoint.y+5))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    func drawThickJacket(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 60, y: 135)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: startPoint)
        
    }
}
