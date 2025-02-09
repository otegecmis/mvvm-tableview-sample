import Foundation

struct WebService {
    func getArticles(completion: @escaping ([Article]?) -> ()) {
        let urlString = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(API_KEY)")
        
        guard let urlString = urlString else { return }
        
        URLSession.shared.dataTask(with: urlString) { data, res, error in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
            }

            if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                if let articleList = articleList {
                    completion(articleList.articles)
                }
            }
        }.resume()
    }
}
