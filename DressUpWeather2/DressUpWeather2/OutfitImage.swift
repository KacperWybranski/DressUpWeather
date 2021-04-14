//
//  OutfitImage.swift
//  DressUpWeather2
//
//  Created by Kacper on 18/03/2021.
//

import UIKit

class OutfitImage: UIImageView {
    func fadeOut() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = 0.0
        }
    }
    
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
                
            switch clothingOptions["jacket"] {
            case "thick":
                if Bool.random() {
                    drawThickJacket(ctx: ctx)
                } else {
                    drawThickJacket2(ctx: ctx)
                }
            case "thin":
                drawThinJacket(ctx: ctx)
            default:
                break
            }
            
            
        }
        
        self.image = img
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: []) { [weak self] in
            self?.alpha = 1.0
        }
        
    }
    
    func drawWhiteBackground(ctx: UIGraphicsRendererContext) {
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
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-12, y: startPoint.y))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+12, y: startPoint.y))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+13, y: startPoint.y+8))
        //arm
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x+27, y: startPoint.y+12), control: CGPoint(x: startPoint.x+20, y: startPoint.y+8))
        //sleeve outer
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x+43, y: startPoint.y+50), control: CGPoint(x: startPoint.x+43, y: startPoint.y+30))
        //welt
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+55))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+35, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+33, y: startPoint.y+55))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+43, y: startPoint.y+50))
        //sleeve inside
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+33, y: startPoint.y+55))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x+25, y: startPoint.y+40), control: CGPoint(x: startPoint.x+25, y: startPoint.y+45))
        //right line center part
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+22, y: startPoint.y+30))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x+25, y: startPoint.y+65), control: CGPoint(x: startPoint.x+28, y: startPoint.y+45))
        //bottom line
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-25, y: startPoint.y+65))
        //left line center part
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x-22, y: startPoint.y+30), control: CGPoint(x: startPoint.x-28, y: startPoint.y+45))
        //sleeve left inside
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-25, y: startPoint.y+40))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x-33, y: startPoint.y+55), control: CGPoint(x: startPoint.x-25, y: startPoint.y+45))
        //welt
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-43, y: startPoint.y+50))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-33, y: startPoint.y+55))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-35, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-45, y: startPoint.y+55))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-43, y: startPoint.y+50))
        //outer sleeve
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x-27, y: startPoint.y+12), control: CGPoint(x: startPoint.x-43, y: startPoint.y+30))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x-13, y: startPoint.y+8), control: CGPoint(x: startPoint.x-20, y: startPoint.y+8))
        //details
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-13, y: startPoint.y))
        ctx.cgContext.move(to: startPoint)
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y+70))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-13, y: startPoint.y+8))
        ctx.cgContext.addCurve(to: CGPoint(x: startPoint.x+13, y: startPoint.y+8), control1: CGPoint(x: startPoint.x-13, y: startPoint.y+15), control2: CGPoint(x: startPoint.x+13, y: startPoint.y+15))
        //pockets
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-21, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+45))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+15, y: startPoint.y+45))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+21, y: startPoint.y+60))
        
        //bottom
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+25, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+25, y: startPoint.y+69))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-25, y: startPoint.y+69))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-25, y: startPoint.y+65))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    func drawThickJacket2(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 60, y: 145)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-12, y: startPoint.y))
        //arm left
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-27, y: startPoint.y+5))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-45, y: startPoint.y+56))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-33, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-22, y: startPoint.y+30))
        //center part
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-22, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+22, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+22, y: startPoint.y+30))
        //arm right
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+33, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+56))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+27, y: startPoint.y+5))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+12, y: startPoint.y))
        //zip
        ctx.cgContext.move(to: CGPoint(x: startPoint.x, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y+10))
        //hood
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x-10, y: startPoint.y-7), control: CGPoint(x: startPoint.x, y: startPoint.y-3))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y-9))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+2))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-15, y: startPoint.y-9))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+15, y: startPoint.y-9))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+15, y: startPoint.y+2))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+15, y: startPoint.y-9))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+10, y: startPoint.y-7))
        ctx.cgContext.addQuadCurve(to: CGPoint(x: startPoint.x, y: startPoint.y+10), control: CGPoint(x: startPoint.x, y: startPoint.y-3))
        //details
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-19, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-3, y: startPoint.y+40))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+3, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+19, y: startPoint.y+40))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    func drawThinJacket(ctx: UIGraphicsRendererContext) {
        let startPoint = CGPoint(x: 60, y: 145)
        
        ctx.cgContext.setStrokeColor(UIColor(white: 1.0, alpha: 1.0).cgColor)
        ctx.cgContext.setLineWidth(3)
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-10, y: startPoint.y-4))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+10, y: startPoint.y-4))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-15, y: startPoint.y+1))
        //arm left
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-27, y: startPoint.y+5))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-45, y: startPoint.y+56))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-33, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-22, y: startPoint.y+30))
        //center part
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-22, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+22, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+22, y: startPoint.y+30))
        //arm right
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+33, y: startPoint.y+60))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+45, y: startPoint.y+56))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+27, y: startPoint.y+5))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+15, y: startPoint.y+1))
        //zip
        ctx.cgContext.move(to: CGPoint(x: startPoint.x, y: startPoint.y+65))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y+20))
        //collar left side
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-15, y: startPoint.y+1))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-10, y: startPoint.y-4))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-3, y: startPoint.y+7))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-8, y: startPoint.y+12))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+1))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-3, y: startPoint.y+7))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y+20))
        //right side
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+15, y: startPoint.y+1))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+10, y: startPoint.y-4))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+3, y: startPoint.y+7))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+8, y: startPoint.y+12))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+15, y: startPoint.y+1))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+3, y: startPoint.y+7))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y+20))
        
        
        //details
        ctx.cgContext.move(to: CGPoint(x: startPoint.x-15, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x-15, y: startPoint.y+60))
        ctx.cgContext.move(to: CGPoint(x: startPoint.x+15, y: startPoint.y+40))
        ctx.cgContext.addLine(to: CGPoint(x: startPoint.x+15, y: startPoint.y+60))
        
        ctx.cgContext.drawPath(using: .stroke)
    }
    
    

}
