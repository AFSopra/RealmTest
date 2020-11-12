//
//  DetailRouter.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import UIKit

class DetailRouter {
    var viewController: UIViewController {
        return self.createViewController()
    }

    private var sourceView: UIViewController?

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

    fileprivate func createViewController() -> UIViewController {
        return DetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
    }

    func navigateToHomeViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
