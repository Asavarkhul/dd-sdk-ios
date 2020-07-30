/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-2020 Datadog, Inc.
 */

import UIKit

final class MasterViewController: ListViewController {
    private var categories = [Category]()

    override func fetch(with api: API) {
        api.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print(error)
            }
            self.reload()
        }
    }

    override func config(cell: Cell, for index: Int) {
        let category = categories[index]
        cell.text = "\(category.id): \(category.title)"
        cell.setImage(url: category.cover)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        let detailVC = DetailViewController(with: selectedCategory)
        show(detailVC, sender: self)
    }
}
