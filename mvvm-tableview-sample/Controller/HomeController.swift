import UIKit

class HomeController: UIViewController {
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        print("DEBUG: HomeController()")
    }
}
