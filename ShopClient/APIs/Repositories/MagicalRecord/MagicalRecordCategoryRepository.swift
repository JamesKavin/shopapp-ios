//
//  MagicalRecordCategoryRepository.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/19/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import MagicalRecord

extension MagicalRecordRepository {
    func loadCategories(with items: [CategoryEntityInterface], callback: @escaping ((_ categories: [CategoryEntity]?, _ error: Error?) -> ())) {
        updateCategory(with: items) { (error) in
            let categoriesIds = items.map({ $0.entityId })
            let predicate = NSPredicate(format: "id IN %@", categoriesIds)
            let categories = CategoryEntity.mr_findAll(with: predicate) as? [CategoryEntity]
            callback(categories, error)
        }
    }
    
    func loadCategory(with item: CategoryEntityInterface, callback: @escaping ((_ category: CategoryEntity?, _ error: Error?) -> ())) {
        updateCategory(with: [item]) { (error) in
            let category = CategoryEntity.mr_findFirst(byAttribute: "id", withValue: item.entityId)
            callback(category, error)
        }
    }
    
    func getCategories() -> [CategoryEntity]? {
        return CategoryEntity.mr_findAll() as? [CategoryEntity]
    }
    
    func getCategory(with id: String) -> CategoryEntity? {
        return CategoryEntity.mr_findFirst(byAttribute: "id", withValue: id)
    }
    
    // MARK: - private
    private func updateCategory(with items: [CategoryEntityInterface], callback: @escaping ((_ error: Error?) -> ())) {
        MagicalRecord.save({ [weak self] (context) in
            for categoryInterface in items {
                let category = CategoryEntity.mr_findFirstOrCreate(byAttribute: "id", withValue: categoryInterface.entityId, in: context)
                self?.update(category: category, with: categoryInterface, in: context)
            }
        }) { (contextDidSave, error) in
            callback(error)
        }
    }
    
    private func update(category: CategoryEntity, with remoteItem: CategoryEntityInterface?, in context: NSManagedObjectContext) {
        category.id = remoteItem?.entityId
        category.title = remoteItem?.entityTitle
        category.categoryDescription = remoteItem?.entityCategoryDescription
        category.updatedAt = remoteItem?.entityUpdatedAt as NSDate?
        category.paginationValue = remoteItem?.entityPaginationValue as? NSObject
        if let remoteAdditionalDescription = remoteItem?.entityAdditionalDescription {
            category.additionalDescription = remoteAdditionalDescription
        }
        if let remoteImage = remoteItem?.entityImage {
            category.image = loadImage(with: remoteImage, in: context)
        }
        if let remoteProducts = remoteItem?.entityProducts {
            category.products = NSSet(array: loadProducts(with: remoteProducts, in: context))
        }
    }
}
