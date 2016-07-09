//
//  CollectionTabViewCell.swift
//  TableViewAndCollectionView
//
//  Created by 刘隆昌 on 15-1-6.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

import UIKit


let collectionViewCellID : NSString = "ColCell"




class CollectionTabViewCell: UITableViewCell {

    var collectionView: UICollectionView!
    
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsetsMake(4, 5, 4, 5)
        layout.minimumLineSpacing = 18
        layout.itemSize = CGSizeMake(91, 91)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellID as String)
        
        self.collectionView.backgroundColor = UIColor.lightGrayColor()
        self.collectionView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(self.collectionView)
        
        
        self.layoutMargins = UIEdgeInsetsMake(10, 0, 10, 0)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let frame = self.contentView.bounds
        self.collectionView.frame = CGRectMake(0, 0.5, frame.size.width, frame.size.height-1)
        
    }
    
   
    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate:protocol<UICollectionViewDelegate,UICollectionViewDataSource>,index:NSInteger){
        
        self.collectionView.dataSource = delegate
        self.collectionView.delegate = delegate
        self.collectionView.tag = index
        self.collectionView.reloadData()
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
