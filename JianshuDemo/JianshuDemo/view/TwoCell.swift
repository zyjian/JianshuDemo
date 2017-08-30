//
//  TwoCell.swift
//  JianshuDemo
//
//  Created by zhu on 2017/8/27.
//  Copyright © 2017年 cn.jy. All rights reserved.
//

import UIKit
class TwoCell: UITableViewCell,ZJScrollPageViewDelegate {
    
    var  currenVC:MineVC?//拥有此cell 的控制器
    var vc0:ContentVC?
    var vc1:ContentVC?
    var vc2:ContentVC?
    
    var topLine:UILabel?
    var bottomLine:UILabel?


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("初始化")
        self.makeUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        
        let style = ZJSegmentStyle.init()
        style.isShowLine = true
        style.segmentHeight = 44
        style.isShowImage = false
        style.isScrollTitle = true
        // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
        style.isAutoAdjustTitlesWidth = true
        style.isContentViewBounces  = false;
        style.selectedTitleColor = UIColor.colorWithHexString(hex: "#D64F11");
        style.scrollLineColor = UIColor.colorWithHexString(hex: "#D64F11")
        
        let titles = ["动态","文章","更多"]
        let frame = CGRect.init(x: 0, y: 0, width: self.screenWidth(), height: self.screenHeight())
        let pageView = ZJScrollPageView.init(frame: frame, segmentStyle: style, titles: titles, parentViewController: currenVC, delegate: self)
        self.addSubview(pageView!)
        
        topLine = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.screenWidth(), height: 1))
        topLine?.backgroundColor = UIColor.colorWithHexString(hex: "#D7D6D7")
        bottomLine = UILabel.init(frame: CGRect.init(x: 0, y: 43, width: self.screenWidth(), height: 1))
        bottomLine?.backgroundColor = UIColor.colorWithHexString(hex: "#D7D6D7")

        pageView?.addSubview(topLine!)
        pageView?.addSubview(bottomLine!)
        

    }

    func showUpLine()  {
        topLine?.bounds = CGRect.init(x: 0, y: 0, width: screenWidth(), height: 1);
    }
    func hideUpLine()  {
        topLine?.bounds = CGRect.init(x: 0, y: 0, width: screenWidth(), height: 0);
    }
    
    func numberOfChildViewControllers() -> Int {
        return 3
    }
    func childViewController(_ reuseViewController: UIViewController!, for index: Int) -> UIViewController! {
        var vc = reuseViewController as? ContentVC
        
        if index == 0 {
            if(vc == nil){
                vc = ContentVC.init()
                vc?.titleSting = "动态"
                vc0 = vc
            }

        }else if index == 1 {
            if(vc == nil){
                vc = ContentVC.init()
                vc?.titleSting  = "文章"
                vc1 = vc
            }

        }
        
        if(vc == nil){
            vc = ContentVC.init()
            vc?.titleSting = "更多"
            vc2 = vc
        }

        return vc
    }
    
    
}
