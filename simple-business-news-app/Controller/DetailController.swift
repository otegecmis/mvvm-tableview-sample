import UIKit
import SafariServices

class DetailController: UIViewController {
    // MARK: - Properties
    var viewModel: ArticleViewModel?

    private var readMoreButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return button
    }()
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var sourceNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .medium)
        
        return label
    }()
    
    private var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var newsImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        
        return imageView
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        titleLabel.text = viewModel?.title
        sourceNameLabel.text = "SOURCE: \(viewModel?.sourceName ?? "Source Name")"
        dateLabel.text = viewModel?.publishedAt.convertToDate()
        descriptionLabel.text = viewModel?.description
        readMoreButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        
        if let imageUrlString = viewModel?.urlToImage,
           let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
                if let error = error {
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.newsImageView.image = image
                    }
                }
            }.resume()
        }
        
        view.addSubview(newsImageView)
        view.addSubview(titleLabel)
        view.addSubview(sourceNameLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            sourceNameLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            sourceNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            sourceNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: sourceNameLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            readMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            readMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            readMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            readMoreButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func openWebsite() {
        guard let article = viewModel, let url = URL(string: article.url) else { return }
        let safariVC = SFSafariViewController(url: url)
        
        present(safariVC, animated: true)
    }
}
