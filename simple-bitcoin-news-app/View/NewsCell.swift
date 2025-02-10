import UIKit

class NewsCell: UICollectionViewCell {
    // MARK: - Properties
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false

        return iv
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private var sourceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(sourceNameLabel)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            sourceNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            sourceNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            sourceNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: sourceNameLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configure(with article: ArticleViewModel) {
        titleLabel.text = article.title
        sourceNameLabel.text = article.sourceName
        
        if let imageUrlString = article.urlToImage,
           let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }.resume()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        sourceNameLabel.text = nil
    }
}
