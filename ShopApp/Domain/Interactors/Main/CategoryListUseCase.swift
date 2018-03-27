//
//  CategoryListUseCase.swift
//  ShopApp
//
//  Created by Radyslav Krechet on 12/29/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import ShopApp_Gateway

class CategoryListUseCase {
    private let repository: CategoryRepository

    init(repository: CategoryRepository) {
        self.repository = repository
    }

    func getCategoryList(paginationValue: Any?, _ callback: @escaping RepoCallback<[Category]>) {
        repository.getCategoryList(perPage: kItemsPerPage, paginationValue: paginationValue, sortBy: nil, reverse: false, callback: callback)
    }
}
