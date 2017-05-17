//
//  Helper.swift
//  Candidates Manager
//
//  Created by Bassem Abbas on 5/16/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation
import  CoreImage
import CoreGraphics
import UIKit
class Helper {
    
    
    class Image {
        
        class func scaleImage (_ oldImage:UIImage?,width:Int?) -> UIImage?{
            if let cgImage = oldImage?.cgImage {
                
                let nwidth = width ?? cgImage.width / 2
                let nheight = ( cgImage.height * width! / cgImage.width ) ?? cgImage.height / 2
                let bitsPerComponent = cgImage.bitsPerComponent
                let bytesPerRow = cgImage.bytesPerRow
                let colorSpace = cgImage.colorSpace
                let bitmapInfo = cgImage.bitmapInfo
                
                if let  context = CGContext(data: nil, width: width!, height: nheight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue) {
                    
                    context.interpolationQuality = CGInterpolationQuality.medium;
                    
                    context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(nwidth), height: CGFloat(nheight))));
                    
                    let scaledImage = context.makeImage().flatMap { UIImage(cgImage: $0) }
                    return scaledImage
                }
            }
            
            
            return nil
            
        }
        
    }

    
}
