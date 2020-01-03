//
//  MenuViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import UIKit

protocol MenuViewControllerInterface: class {

    func loadMenuItems()
}

extension MenuViewController {
    private enum CellType: Int{
        case menuItem = 0
    }
}

class MenuViewController: UIViewController {
    var presenter: MenuPresenterInterface?
    @IBOutlet weak var menuCollectionView: UICollectionView! {
        didSet{
            menuCollectionView.registerNibCells(classNames: [MenuItemCollectionViewCell.self])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
        
    }
}


extension MenuViewController: MenuViewControllerInterface {
    func loadMenuItems() {
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
    

    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCollectionViewCell", for: indexPath) as! MenuItemCollectionViewCell
        
        if let menuItem = presenter?.getMenuItems(){
            cell.configure(menuItem: menuItem[indexPath.row])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width), height: 250)
    }
    
    
}
