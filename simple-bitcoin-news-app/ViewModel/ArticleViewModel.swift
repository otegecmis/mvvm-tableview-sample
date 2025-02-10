import Foundation

struct ArticleViewModel {
    // MARK: - Properties
    private let article: Article
    
    var title: String {
        return self.article.title ?? "Title"
    }
    
    var url: String {
        return self.article.url ?? "https://www.google.com"
    }
    
    var publishedAt: String {
        return self.article.publishedAt ?? "0000-00-00T00:00:00Z"
    }
    
    var sourceName: String {
        return self.article.source?.name ?? "Source Name"
    }
    
    var description: String {
        return self.article.description ?? "Description"
    }
    
    var urlToImage: String? {
        return self.article.urlToImage
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
    
    func urlForArticle(at index: Int) -> URL? {
        return URL(string: articles[index].url ?? "https://www.google.com")
    }
}
