//
//  MenuRouter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import Foundation
import UIKit

protocol MenuRouterInterface: class {

}

class MenuRouter: NSObject {

    weak var presenter: MenuPresenterInterface?

    static func setupModule() -> MenuViewController? {
        let storyboard = StoryBoard.ocakbasi
        if let view = storyboard.instantiateInitialViewController() as? MenuViewController {
            let interactor = MenuInteractor()
            let router = MenuRouter()
            let presenter = MenuPresenter(interactor: interactor, router: router, view: view)

            view.presenter = presenter
            router.presenter = presenter
            interactor.output = presenter
            
            return view
        }
        fatalError("MenuItem module can not created")
        
    }
}

extension MenuRouter: MenuRouterInterface {

}

