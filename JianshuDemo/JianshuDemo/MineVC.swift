//
//  MineVC.swift
//  JianshuDemo
//
//  Created by zhu on 2017/8/27.
//  Copyright © 2017年 cn.jy. All rights reserved.
//

import UIKit

class MineVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    let MaxSize:CGFloat = 60 //图像最大值
    let MinSize:CGFloat = 30 //图像最小值
    let TopHeight:CGFloat = 240 //最上面的大小
    var scrollSegementView:UIView?
    var myTableView:UITableView?
    
    var myTwoCell:TwoCell?//当前前cell
    var canScroll:Bool? = true //当前tabView是否可以滑动
       
    
    private var headImgView:UIImageView?
    private var navLine:UILabel?
    
    


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        self.makeUI()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        headImgView = UIImageView.init(image: UIImage.init(named: "headicon"))
        let width:CGFloat = MaxSize
        let ox = screenWidth()/2-width/2
        headImgView?.frame = CGRect.init(x: ox, y: 25, width: width, height: width)
        self.view.addSubview(headImgView!)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reciverMessage(nc:)), name: NSNotification.Name.init(rawValue: "MAINPOST"), object: nil);
        
        self.myTableView?.scrollsToTop = true

    }
    func reciverMessage(nc:Notification) {
        let obj  = nc.object as! Bool
        self.canScroll = obj
        print("mianobj==\(obj))")
    }
    
    //scrollView代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var oy = scrollView.contentOffset.y
        if oy>100 {
            oy = 100
        }else if oy < 0{
            oy = 0
        }
//        print(oy)
        //100  --30,30
        //0   --- 60,60
        let oneadd:CGFloat = (60-30)/100
        
        let currntSize = MaxSize - oneadd*oy
        
        let width:CGFloat = currntSize
        let ox = screenWidth()/2-width/2
        headImgView?.frame = CGRect.init(x: ox, y: 25, width: width, height: width)

        
        
        //处理线下面的横线
        oy = scrollView.contentOffset.y
//        print("currnt----\(oy)")
        if oy >= TopHeight {
            navLine?.frame = CGRect.init(x: 0, y: 43,width: screenWidth(), height: 0)
            self.myTwoCell?.hideUpLine()
        }else{
            navLine?.frame = CGRect.init(x: 0, y: 43,width: screenWidth(), height: 1)
            self.myTwoCell?.showUpLine()

        }
        
        
        
        
        //处理手势问题
        if oy >= TopHeight {
            scrollView.contentOffset = CGPoint.init(x: 0, y: TopHeight)
           
            if self.canScroll! {
                self.canScroll = false  //自己不动
                //通知子类动
                let nc = NotificationCenter.default
                nc .post(name: NSNotification.Name.init(rawValue: "POST"), object: true)
            }
           
        }else{
            if (!self.canScroll!) {//到最顶部
                scrollView.contentOffset = CGPoint.init(x: 0, y: TopHeight)
            }
           
        }
        
 
        scrollView.showsVerticalScrollIndicator = self.canScroll! ? true:false;

        
    }
    
    
    
    //导航栏定制
    func makeUI(){
        self.view.backgroundColor = UIColor.white
        
        /*
        //去掉左侧的空白20px
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -20;
        
        
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        leftBtn.setImage(UIImage.init(named: "icom_fanhui"), for: .normal)
        leftBtn.addTarget(self, action: #selector(pressLeft), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.setLeftBarButtonItems([negativeSpacer, item], animated: true)
        */
        
        let navView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: screenWidth(), height: 44))
        navView.backgroundColor = UIColor.white
        
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        leftBtn.setImage(UIImage.init(named: "icom_fanhui"), for: .normal)
        leftBtn.addTarget(self, action: #selector(pressLeft), for: .touchUpInside)
        
        navView.addSubview(leftBtn)
        self.view.addSubview(navView)
        
        navLine = UILabel.init(frame: CGRect.init(x: 0, y: 43,width: screenWidth(), height: 1))
        navView.addSubview(navLine!)
        navLine?.backgroundColor = UIColor.colorWithHexString(hex: "#D7D6D7")
        
        
        
        //初始化tableview
        myTableView = GestureTableView.init(frame: CGRect.init(x: 0, y: 64, width: self.screenWidth(), height: self.screenHeight()), style: .plain)
        self.view.addSubview(myTableView!)
        myTableView?.delegate = self
        myTableView?.dataSource = self
    }
    func pressLeft(){
        print("pressleft")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*代理方法*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return TopHeight
        }
        return self.screenHeight()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "OneCell")
            if(cell==nil){
                cell = (Bundle.main.loadNibNamed("OneCell", owner: nil, options: nil)?.first as! UITableViewCell)
            }
            cell?.selectionStyle = .none
            return cell!
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "TwoCell") as? TwoCell
        if(cell == nil){
            cell = TwoCell.init(style: .default, reuseIdentifier: "TwoCell")
        }
        weak var weakSelf = self
        cell?.currenVC = weakSelf
        cell?.selectionStyle = .none
        myTwoCell = cell
        return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
}




