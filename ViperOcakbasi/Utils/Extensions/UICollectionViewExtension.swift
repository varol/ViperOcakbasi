//
//  UICollectionViewExtension.swift
//  ViperOcakbasi
//
//  Created by VAROL AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerClass(cellClass: AnyClass) {
        let className = String.init(describing: cellClass)
        
        if let _ = Bundle.main.path(forResource: className, ofType: "nib") {
            self.register(UINib.init(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
        }
        else {
            self.register(cellClass, forCellWithReuseIdentifier: className)
        }
    }
    
    
    func registerNibCells(classNames: [AnyClass]) {
        if classNames.count > 0 {
            for className in classNames {
                self.registerClass(cellClass: className)
            }
        }
    }
}
