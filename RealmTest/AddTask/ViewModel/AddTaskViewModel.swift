//
//  AddTaskViewModel.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import Foundation

class AddTaskViewModel {
    private var view: AddTaskViewController?
    private var router: AddTaskRouter?

    func bind(view: AddTaskViewController, router: AddTaskRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func makeAddTaskView() {
        self.router?.navigateToHomeViewController()
    }
}
