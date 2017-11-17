//
//  ArticleDetailsViewController.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 9/26/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleDetailsViewController: BaseViewController<ArticleDetailsViewModel> {
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    
    var articleId: String!
    
    override func viewDidLoad() {
        viewModel = ArticleDetailsViewModel()
        super.viewDidLoad()

        setupViewModel()
        loadData()
    }
    
    private func setupViewModel() {
        viewModel.articleId = articleId
    }
    
    private func loadData() {
        viewModel.data
            .subscribe(onSuccess: { [weak self] (article) in
                self?.populateViews(with: article)
            })
            .disposed(by: disposeBag)
    }
    
    private func populateViews(with article: Article) {
        let imageUrl = URL(string: article.image?.src ?? String())
        articleImageView.sd_setImage(with: imageUrl)
        articleTitleLabel.text = article.title
        authorNameLabel.text = article.author?.fullName
        articleContentLabel.text = article.content
    }
    
    // MARK: - ErrorViewProtocol
    func didTapTryAgain() {
        loadData()
    }
}
