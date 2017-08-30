//
//  ContentVC.swift
//  JianshuDemo
//
//  Created by zhu on 2017/8/27.
//  Copyright © 2017年 cn.jy. All rights reserved.
//



class ContentVC: UIViewController,ZJScrollPageViewChildVcDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    var titleSting:String?
    var myTableView:UITableView?
    
    var canScroll:Bool? = false//是否可以滑动
    

    override func viewDidLoad() {
        myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth(), height: screenHeight()-64-44), style: .plain)
        myTableView?.delegate = self
        myTableView?.dataSource = self
        self.view.addSubview(myTableView!)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(receivePostNotifi(nc:)), name: NSNotification.Name.init(rawValue: "POST")  , object: nil)
        self.myTableView?.scrollsToTop = true
    }
    func receivePostNotifi(nc:Notification) {
       
        let obj  = nc.object as! Bool
        
        if obj {
            self.canScroll = true
        }
        
        print("obj==\(obj))")

        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (!self.canScroll!) {
            scrollView.contentOffset = CGPoint.zero
        
        }
    
        let oy = scrollView.contentOffset.y
        if oy <= 0 {
            
            //主动子不动
            self.canScroll = false
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name.init(rawValue: "MAINPOST"), object: true)
            scrollView.contentOffset = CGPoint.zero
            
        }
        
        
        scrollView.showsVerticalScrollIndicator = self.canScroll! ? true:false;

        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: "CellID")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "CellID")
        }
        
        cell?.textLabel?.text = self.titleSting! + "这是第\(indexPath.row)行"
        
        return cell!
    }
}
