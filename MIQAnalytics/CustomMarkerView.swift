//
//  CustomMarkerView.swift
//  MIQAnalytics
//
//  Created by Girish on 03/12/19.
//  Copyright © 2019 Girish. All rights reserved.
//

import UIKit

class CustomMarkerView: UIView {
    var img: UIImage!
    var borderColor: UIColor!
    var title : String!
    var code :   Int!
    var healthperc : Float!
    
    
//    init(frame: CGRect, image: UIImage, borderColor: UIColor, tag: Int , title:String ) {
//        super.init(frame: frame)
//        self.img=image
//        self.borderColor=borderColor
//        self.tag = tag
//        self.title =  title
//        var titlewidth = title.stringWidth
//        
//        
//        setupViews(strWidth: titlewidth)
//    }
    init(frame: CGRect, borderColor: UIColor, tag: Int , title:String  , code : Int , healthperc : Float) {
        super.init(frame: frame)
        
        self.borderColor=borderColor
        self.tag = tag
        self.title =  title
        let titlewidth = title.stringWidth
        self.code = code
        self.healthperc = healthperc
        
        setupViews(strWidth: titlewidth)
    }
    
    func setupViews(strWidth : CGFloat) {
        let imgView = UIImageView(image: img)
         let lbl=UILabel()
         let lbl2 = UILabel()
        
        imgView.frame=CGRect(x: 0, y: 0, width: 100, height: 50)
       
       // lbl.frame  = CGRect(x: 5, y: 0,width: 150,height: 50)
        lbl.frame  = CGRect(x: 0, y: 20,width: 100,height: 20)
        imgView.layer.borderColor=borderColor?.cgColor
        imgView.layer.borderWidth=2
        imgView.clipsToBounds=true
        lbl.text = title
        lbl.font=UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor=UIColor.white
        lbl.backgroundColor=UIColor.black
        lbl.textColor = UIColor(hexString: "#039dfc")
        lbl.layer.borderColor = UIColor(hexString: "#039dfc")?.cgColor;
        lbl.layer.borderWidth = 2.0;
        lbl.padding = UIEdgeInsets(top: 2, left: 1, bottom: 3, right: 1)
        
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 4
        lbl.clipsToBounds=true
       // lbl.translatesAutoresizingMaskIntoConstraints=false
        // self.addSubview(imgView)
        
        
         lbl2.frame  = CGRect(x: 40, y: 0,width: 25,height: 25)
        let health = Int(healthperc)
         lbl2.text = String(health)
         lbl2.font=UIFont.boldSystemFont(ofSize: 16)
         lbl2.textColor=UIColor.white
        if code == 3 {
             lbl2.layer.borderColor = UIColor.orange.cgColor
        }
        if code == 2 {
             lbl2.layer.borderColor = UIColor.yellow.cgColor
        }
        if code == 1 {
             lbl2.layer.borderColor = UIColor(hexString: "#039dfc")?.cgColor;
        }
         lbl2.backgroundColor=UIColor.black
        
         lbl2.layer.borderWidth = 2.0;
         
         lbl2.textAlignment = .center
         lbl2.layer.cornerRadius =  lbl2.frame.height/2
        
         lbl2.clipsToBounds=true
         //lbl2.layer.animateBorderColor(from: UIColor.green, to: UIColor.red, withDuration: 1.0)
         lbl2.blink()
        self.addSubview(lbl)
        self.addSubview(lbl2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}
extension UIView {
    func blink(duration: Double=0.5, repeatCount: Int=100000) {
        self.alpha = 0.0;
        UIView.animate(withDuration: duration,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in
                UIView.setAnimationRepeatCount(Float(repeatCount) + 0.5)
                self?.alpha = 1.0
            }
        )
    }
}
extension UIView {
  func animateBorderWidth(toValue: CGFloat, duration: Double) {
    let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
    animation.fromValue = layer.borderWidth
    animation.toValue = toValue
    animation.duration = duration
    layer.add(animation, forKey: "Width")
    layer.borderWidth = toValue
  }
}
extension CALayer {
    
    

func animateBorderColor(from startColor: UIColor, to endColor: UIColor, withDuration duration: Double) {
    let colorAnimation = CABasicAnimation(keyPath: "borderColor")
    colorAnimation.fromValue = startColor.cgColor
    colorAnimation.toValue = endColor.cgColor
    colorAnimation.duration = duration
    self.borderColor = endColor.cgColor
    self.add(colorAnimation, forKey: "borderColor")
}
}
extension String {
    var stringWidth: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        return boundingBox.width
    }

    var stringHeight: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        return boundingBox.height
    }
}
