//
//  HomeViewModel.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import Foundation

class HomeViewModel {
    private var view: HomeViewController?
    private var router: HomeRouter?

    func bind(view: HomeViewController, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func makeAddTaskView() {
        self.router?.navigateToAddTaskViewController()
    }

    func makeDetailView() {
        self.router?.navigateToDetailViewController()
    }
}
