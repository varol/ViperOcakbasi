//
//  MenuPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import Foundation

protocol MenuPresenterInterface: class {
    //MARK:- View-> Presenter
    func viewDidAppear()
    func getMenuItems() -> [MenuItem]?
    
    //MARK:- CollectionView -> Presenter
    func getNumberOfRows() -> Int
}


final class MenuPresenter {

    unowned var view: MenuViewControllerInterface
    private let router: MenuRouterInterface?
    private let interactor: MenuInteractorInterface?
    
    var menuItemResponse : [MenuItem]?
    
    init(interactor: MenuInteractorInterface,
         router: MenuRouterInterface,
         view: MenuViewControllerInterface) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        self.menuItemResponse = nil
    }
}

extension MenuPresenter: MenuPresenterInterface {
    func getNumberOfRows() -> Int {
        return menuItemResponse?.count ?? 0
    }
        
    func getMenuItems() -> [MenuItem]? {
        return menuItemResponse
    }
    
    func viewDidAppear() {
        DispatchQueue.main.async {
            self.interactor?.fetchMenuItems()
        }
    }

}

extension MenuPresenter: MenuItemInteractorInterfaceOutput {
    func handleMenuItemResult(result: MenuItemResult) {
        switch result {
        case .success(let menuItemDataResult):
            self.menuItemResponse = menuItemDataResult
            view.loadMenuItems()
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
}
