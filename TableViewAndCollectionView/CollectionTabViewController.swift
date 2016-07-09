//
//  CollectionTabViewController.swift
//  TableViewAndCollectionView
//
//  Created by 刘隆昌 on 15-1-5.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

import UIKit

let reuseTabCellID = "TabCell"
let reuseColCellID = "ColCell"


class CollectionTabViewController: UITableViewController {
    
    var sourceArray:NSArray!
    var contentOffSetDic:NSMutableDictionary!
    
    convenience init(source:NSMutableArray){
        
        self.init()
        self.tableView.registerClass(CollectionTabViewCell.self,forCellReuseIdentifier:reuseTabCellID)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.sourceArray = NSArray(array: source)
        self.contentOffSetDic = NSMutableDictionary()
        
    }
    
}


extension CollectionTabViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseTabCellID, forIndexPath: indexPath) as! CollectionTabViewCell
        return cell
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let collectionCell : CollectionTabViewCell = cell as! CollectionTabViewCell
    
        collectionCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
        
        let index:NSInteger = collectionCell.collectionView.tag
        let value: AnyObject? = self.contentOffSetDic.valueForKey(index.description)
        let horizontalOffset: CGFloat = CGFloat(value != nil ? value!.floatValue:0)
        collectionCell.collectionView.setContentOffset(CGPointMake(horizontalOffset, 0), animated: false)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}




extension CollectionTabViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewArray:NSArray = self.sourceArray[collectionView.tag] as! NSArray
        return collectionViewArray.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseColCellID, forIndexPath: indexPath) as UICollectionViewCell
        
        
        let collectionViewArray = self.sourceArray[collectionView.tag] as! NSArray
        
        cell.backgroundColor = collectionViewArray[indexPath.item] as? UIColor
        
        return cell;
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let itemColor: UIColor = self.sourceArray[collectionView.tag][indexPath.item] as! UIColor
        
        
        if UIDevice.currentDevice().systemVersion >= "8.0"{
            
            let alert = UIAlertController(title: "第\(collectionView.tag)行", message: "第\(indexPath.item)个元素", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            let v: UIView = UIView(frame: CGRectMake(20, 20, 50, 50))
            
            v.backgroundColor = itemColor
            
            alert.view.addSubview(v)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if !scrollView.isKindOfClass(UICollectionView){
            return
        }
        let horizontalOffset: CGFloat = scrollView.contentOffset.x
        let collectionView: UICollectionView = scrollView as! UICollectionView
        self.contentOffSetDic.setValue(horizontalOffset, forKey: collectionView.tag.description)
        
    }
   
    
    
}




