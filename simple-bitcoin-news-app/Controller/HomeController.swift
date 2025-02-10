import UIKit
import SafariServices

private let reusableIdentifier = "NewsCell"

class HomeController: UITableViewController {
    // MARK: - Properties
    private var viewModel: ArticleListViewModel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureRefreshControl()
        fetchData()
    }
    
    // MARK: - API
    func fetchData() {
        WebService().getArticles() { articles in
            if let articles = articles {
                self.viewModel = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Bitcoin News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    // MARK: - Selectors
    @objc func handleRefresh() {
        fetchData()
    }
}

// MARK: - Extensions
extension HomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? NewsCell else {
            fatalError("NOT FOUND: NewsCell")
        }
        
        let article = viewModel.articleAtIndex(indexPath.row)
        
        cell.titleLabel.text = article.title
        cell.sourceNameLabel.text = article.sourceName
        cell.dateLabel.text = article.publishedAt.convertToDate()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel == nil ? 0 : viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        
        detailController.viewModel = viewModel.articleAtIndex(indexPath.row)
        navigationController?.pushViewController(detailController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
