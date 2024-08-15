import Foundation

struct ArticleViewModel {
    // MARK: - Properties
    private let article: Article
    
    var title: String {
        return self.article.title
    }
    
    var description: String {
        return self.article.description
    }
    
    // MARK: - Lifecycles
    init(_ article: Article) {
        self.article = article
    }
}

struct ArticleListViewModel {
    // MARK: - Properties
    let articles: [Article]
    
    var numberOfSections: Int {
        return 1
    }
    
    // MARK: - Helpers
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}
