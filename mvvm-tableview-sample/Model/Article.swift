import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let url: String?
    let author: String?
    let publishedAt: String?
}
