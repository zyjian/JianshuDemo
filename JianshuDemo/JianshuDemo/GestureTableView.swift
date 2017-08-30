//
//  GestureTableView.swift
//  JianshuDemo
//
//  Created by zhu on 2017/8/28.
//  Copyright © 2017年 cn.jy. All rights reserved.
//

class GestureTableView: UITableView,UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
