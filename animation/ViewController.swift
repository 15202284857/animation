//
//  ViewController.swift
//  animation
//
//  Created by yeqingyu on 16/6/4.
//  Copyright © 2016年 yeqingyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var reload: UIBarButtonItem!
    var tableviews:UITableView?
    var scrollerY:CGFloat = -64
    
    lazy var datas:[String] = {
    
    return ["s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff","s","sdsdsd","fff"]
    }()
    /**
     /**
     * 提示:转场的动画的类型（type）和子头型(subtype) 能用字符串常量就用字符常量
     */
     
     
     /**
     *******************************************************
     type:动画类型(比如：滴水效果，翻转效果...)
     -------------------------------------------------------
     fade kCATransitionFade 交叉淡化过渡
     moveIn kCATransitionMoveIn 新视图移到旧视图上面
     push kCATransitionPush 新视图把旧视图推出去
     reveal kCATransitionReveal 将旧视图移开,显示下面的新视图
     pageCurl               向上翻一页
     pageUnCurl             向下翻一页
     rippleEffect             滴水效果
     suckEffect 收缩效果，如一块布被抽走
     cube                   立方体效果
     oglFlip              上下左右翻转效果
     rotate     旋转效果
     cameraIrisHollowClose 相机镜头关上效果(不支持过渡方向)
     cameraIrisHollowOpen 相机镜头打开效果(不支持过渡方向)
     
     *******************************************************
     subtype: 动画方向(比如说是从左边进入，还是从右边进入...)
     ------------------------------------------------------
     kCATransitionFromRight;
     kCATransitionFromLeft;
     kCATransitionFromTop;
     kCATransitionFromBottom;
     
     当 type 为@"rotate"(旋转)的时候,它也有几个对应的 subtype,分别为:
     90cw 逆时针旋转 90°
     90ccw 顺时针旋转 90°
     180cw 逆时针旋转 180°
     180ccw  顺时针旋转 180°
     **/
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let with:CGFloat = 50
        
        for i in 0..<10 {
            let btn = UIButton(type: UIButtonType.System)
            let subI = CGFloat(i)

            btn.frame = CGRectMake(50*subI, 70, with, 40)
            btn.backgroundColor = UIColor.yellowColor()
            btn.setTitle("i", forState: UIControlState.Normal)
            view .addSubview(btn)
            
            btn.addTarget(self, action:#selector(ViewController.reflesh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
        }
        
        let tableview = UITableView()
        tableviews = tableview
        tableview.frame = CGRectMake(0, 200, view.bounds.size.width, view.bounds.size.height-100)
        tableview.contentOffset.y = 100
        tableview.backgroundColor = UIColor.yellowColor()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        navigationController?.setToolbarHidden(true, animated: true)


    }

    
    func reflesh(btn:UIButton) {
        print(btn)
        let animation = CATransition()
        animation.type = "push"
        animation.subtype = "fromRight"
        animation.duration = 0.5
        tableviews!.layer.addAnimation(animation, forKey: nil)
        tableviews?.reloadData()
    }
    
    @IBAction func reload(sender: AnyObject) {
        
       tableviews?.reloadData()

    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let value = scrollerY-scrollView.contentOffset.y
        print(scrollView.decelerationRate)
        
        if (value<0&&value < -150) {
            print("向上滑动")
            
            UIView.animateWithDuration(0.6, animations: {
                
                self.navigationController?.navigationBar.frame.origin.y = -64
                self.tabBarController?.tabBar.frame.origin.y = UIScreen.mainScreen().bounds.size.height
          
            })
            
        }else if(value>0&&value > 150){
           print("向下滑动")
           UIView.animateWithDuration(0.6, animations: {
                self.navigationController?.navigationBar.frame.origin.y = 20
                self.tabBarController?.tabBar.frame.origin.y = UIScreen.mainScreen().bounds.size.height-49
            })
          
        
        }
        
 
        
        
    }
    
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollerY = scrollView.contentOffset.y
           
        
    }
    
}





//  MARK -代理方法
  extension  ViewController:UITableViewDataSource,UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell==nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            
            cell?.textLabel?.text = datas[indexPath.row]

        }
        return cell!
    }
    

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
//        UIView.animateWithDuration(0.25) {
//            cell.transform = CGAffineTransformMakeScale(1, 1)
//            cell.alpha = 1
//        }
        
        
//        let animation = CATransition()
//        animation.type = "push"
//        animation.subtype = "fromLeft"
//        animation.duration = 0.5
//        tableView.layer.addAnimation(animation, forKey: nil)
    }
}

