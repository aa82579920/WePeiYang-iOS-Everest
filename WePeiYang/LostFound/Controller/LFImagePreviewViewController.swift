//
//  LFImagePreviewViewController.swift
//  WePeiYang
//
//  Created by JasonEWNL on 2018/10/20.
//  Copyright © 2018年 twtstudio. All rights reserved.
//

import UIKit
import SDWebImage

class LFImagePreviewViewController: UIViewController {
    
    var imageString = ""
    
    init(image: String) {
        self.imageString = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = .black
        scrollView.isUserInteractionEnabled = true
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        
        imageView = UIImageView()
        if imageString != "" {
            if let imageURL = URL(string: imageString) {
                imageView.sd_setImage(with: imageURL)
            }
        } else {
            imageView.image = #imageLiteral(resourceName: "LFNoImage")
        }
        imageView.isUserInteractionEnabled = true
        imageView.frame = scrollView.frame
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        self.view.addSubview(scrollView)
        
        // 单击
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingleDid(_:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        
        // 双击
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(tapDoubleDid(_:)))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        
        tapSingle.require(toFail: tapDouble)
        self.imageView.addGestureRecognizer(tapSingle)
        self.imageView.addGestureRecognizer(tapDouble)
    }
    // 单击
    @objc func tapSingleDid(_ ges: UITapGestureRecognizer) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    // 双击
    @objc func tapDoubleDid(_ ges: UITapGestureRecognizer) {
        // 在点击处进行缩放
        UIView.animate(withDuration: 0.5, animations: {
            if self.scrollView.zoomScale == 1.0 {
                let pointInView = ges.location(in: self.imageView)
                let newZoomScale: CGFloat = 2.0
                let scrollViewSize = self.scrollView.bounds.size
                let w = scrollViewSize.width / newZoomScale
                let h = scrollViewSize.height / newZoomScale
                let x = pointInView.x - (w / 2.0)
                let y = pointInView.y - (h / 2.0)
                let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
                self.scrollView.zoom(to: rectToZoomTo, animated: true)
            } else {
                self.scrollView.zoomScale = 1.0
            }
        })
    }
    
}
extension LFImagePreviewViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    // image中心缩放
    //    func scrollViewDidZoom(_ scrollView: UIScrollView) {
    //        var centerX = scrollView.center.x
    //        var centerY = scrollView.center.y
    //        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2: centerX
    //        centerY = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2: centerY
    //        imageView.center = CGPoint(x: centerX, y: centerY)
    //
    //    }
    
}
