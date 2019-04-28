//
//  TrendsDetailController.swift
//  WePeiYang
//
//  Created by 王春杉 on 2019/2/25.
//  Copyright © 2019 twtstudio. All rights reserved.
//  ok

import UIKit
import Alamofire
import MJRefresh

class TrendsDetailController: UIViewController {
    var titleLable = UILabel()
    var timeLable = UILabel()
    var visitsImageView = UIImageView()
    var visitsLable = UILabel()
    var mainLable = UILabel()
    var scrollView = UIScrollView()
    var lineLable = UILabel()
    var fileImageView1 = UIImageView()
    var fileBtn1 = UIButton(type: UIButtonType.system)
    var fileImageView2 = UIImageView()
    var fileBtn2 = UIButton(type: UIButtonType.system)
    var fileImageView3 = UIImageView()
    var fileBtn3 = UIButton(type: UIButtonType.system)
    var attachArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "详情"
        self.view.backgroundColor = .white

        self.setUIKit()
    }
    func setUIKit() {
        let padding: CGFloat = 20

        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSize(width: Device.width, height: Device.height*4)
        self.view.addSubview(scrollView)


        titleLable.frame = CGRect(x: padding, y: padding, width: Device.width-(padding*2), height: 60)
        titleLable.numberOfLines = 2
        titleLable.font = UIFont.systemFont(ofSize: 25)
        self.scrollView.addSubview(titleLable)

        timeLable.frame = CGRect(x: padding, y: titleLable.y + padding + titleLable.height, width: Device.width/4, height: 20)
        timeLable.textColor = .gray
        self.scrollView.addSubview(timeLable)

        visitsImageView.frame = CGRect(x: Device.width-padding-Device.width/9-30, y: timeLable.y-5, width: 30, height: 30)
        visitsImageView.image = UIImage(named: "浏览量")
        self.scrollView.addSubview(visitsImageView)

        visitsLable.frame = CGRect(x: Device.width-padding-Device.width/9, y: timeLable.y, width: Device.width/9, height: 20)
        visitsLable.textColor = .gray
        self.scrollView.addSubview(visitsLable)

        // 使用Alamofire 加载 DetailMusic
        let RecruitmentUrl = "http://job.api.twtstudio.com/api/notice/detail?type=1&id=\(didSelectCell.id)"
        Page.url = RecruitmentUrl
        TrendDetailHelper.getTrendDetail(success: { announcement in
            self.titleLable.text = (announcement.data?.title)!
            self.visitsLable.text = String((announcement.data?.click)!)
            self.timeLable.text = (announcement.data?.date)!
            
            
            let content = (announcement.data?.content)!
            self.mainLable.frame = CGRect(x: padding, y: self.timeLable.y + padding + self.timeLable.height, width: Device.width-(padding*2), height: self.heightForView(text: content, font: UIFont.systemFont(ofSize: 13.7), width: Device.width-(padding*2)))
            //self.mainLable.text = content
            self.mainLable.numberOfLines = 0
            self.mainLable.lineBreakMode = NSLineBreakMode.byClipping
            self.mainLable.attributedText = self.getAttriFrom(str: content)
            //self.mainLable.font = UIFont.systemFont(ofSize: 17)
            self.scrollView.addSubview(self.mainLable)
            //计算高度
            let size:CGRect = self.mainLable.attributedText!.boundingRect(with:  CGSize(width: Device.width-32, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue), context: nil)
            var newFrame = self.mainLable.frame
            newFrame.size.height = size.height
            self.mainLable.frame = newFrame
            
            
            self.lineLable.frame = CGRect(x: padding, y: self.mainLable.y+self.mainLable.height+padding, width: Device.width-padding*2, height: 2)
            self.lineLable.textColor = .black
            self.lineLable.text = "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
            self.lineLable.font = UIFont.systemFont(ofSize: 10)
            self.scrollView.addSubview(self.lineLable)
            self.setScrollView(byLastView: self.lineLable)
            
            if announcement.data?.attach1 != nil {
                self.attachArray.append((announcement.data?.attach1)!)
                self.fileImageView1.image = UIImage(named: "文件")
                self.fileImageView1.frame = CGRect(x: padding, y: self.lineLable.y+padding*2, width: 40, height: 40)
                self.scrollView.addSubview(self.fileImageView1)
                
                self.fileBtn1.frame = CGRect(x: self.fileImageView1.x+40, y: self.fileImageView1.y+5, width: Device.width-padding*2-self.fileImageView1.width, height: 40)
                self.fileBtn1.setTitle((announcement.data?.attach1Name)!, for: .normal)
                self.fileBtn1.titleLabel?.numberOfLines = 0
                self.fileBtn1.titleLabel!.font = UIFont.systemFont(ofSize: 15)
                self.fileBtn1.tag = 1
                self.fileBtn1.addTarget(self, action: #selector(self.clickFile(button:)), for: .touchUpInside)
                self.fileBtn1.contentHorizontalAlignment = .left
                self.scrollView.addSubview(self.fileBtn1)
                self.setScrollView(byLastView: self.fileImageView1)
            }
            
            if announcement.data?.attach2 != nil {
                self.attachArray.append((announcement.data?.attach1)!)
                self.fileImageView2.image = UIImage(named: "文件")
                self.fileImageView2.frame = CGRect(x: padding, y: self.fileImageView1.y+40+padding, width: 40, height: 40)
                self.scrollView.addSubview(self.fileImageView2)
                
                self.fileBtn2.frame = CGRect(x: self.fileImageView2.x+40, y: self.fileImageView2.y+5, width: Device.width-padding*2-self.fileImageView2.width, height: 40)
                self.fileBtn2.setTitle((announcement.data?.attach2Name)!, for: .normal)
                self.fileBtn2.titleLabel?.numberOfLines = 0
                self.fileBtn2.titleLabel!.font = UIFont.systemFont(ofSize: 15)
                self.fileBtn2.tag = 2
                self.fileBtn2.addTarget(self, action: #selector(self.clickFile(button:)), for: .touchUpInside)
                self.scrollView.addSubview(self.fileBtn2)
                self.fileBtn2.contentHorizontalAlignment = .left
                self.setScrollView(byLastView: self.fileImageView2)
            }
            
            if announcement.data?.attach3 != nil {
                self.attachArray.append((announcement.data?.attach3)!)
                self.fileImageView3.image = UIImage(named: "文件")
                self.fileImageView3.frame = CGRect(x: padding, y: self.fileImageView2.y+40+padding, width: 40, height: 40)
                self.scrollView.addSubview(self.fileImageView3)
                
                self.fileBtn3.frame = CGRect(x: self.fileImageView3.x+40, y: self.fileImageView3.y+5, width: Device.width-padding*2-self.fileImageView3.width, height: 40)
                self.fileBtn3.setTitle((announcement.data?.attach3Name)!, for: .normal)
                self.fileBtn3.titleLabel?.numberOfLines = 0
                self.fileBtn3.titleLabel!.font = UIFont.systemFont(ofSize: 15)
                self.fileBtn3.tag = 3
                self.fileBtn3.addTarget(self, action: #selector(self.clickFile(button:)), for: .touchUpInside)
                self.scrollView.addSubview(self.fileBtn3)
                self.fileBtn3.contentHorizontalAlignment = .left
                self.setScrollView(byLastView: self.fileImageView3)
            }
        }) { _ in
            
        }


    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{

        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()

        return label.frame.height
    }
    func getAttriFrom(str: String) -> NSMutableAttributedString {
        let htmlStr = "<head><style>img{max-width:\(Device.width-30)px !important; height:auto}</style></head>" + "<div style='font-size:13.7px'>" + str + "</div>"
        let attStr = try? NSMutableAttributedString.init(data: htmlStr.data(using: String.Encoding.utf16)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attStr ?? NSMutableAttributedString()

    }
    func setScrollView(byLastView: UIView) {
        var newContentSize = self.scrollView.contentSize
        newContentSize.height = byLastView.y + 100
        self.scrollView.contentSize = newContentSize
    }
    @objc func clickFile(button: UIButton) {
        AttachHttp.http = attachArray[button.tag-1]
        self.navigationController?.pushViewController(FilePreviewController(), animated: true)
    }
}