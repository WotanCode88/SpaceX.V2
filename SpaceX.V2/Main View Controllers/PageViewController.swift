import UIKit

final class PageViewController: UIPageViewController {
    
    let falconHeavy = RocketViewController(nameOfRocket: "Falcon Heavy", nameOfImage: "FalconHeavy")
    let falcon9 = RocketViewController(nameOfRocket: "Falcon 9", nameOfImage: "falcon9")
    let falcon1 = RocketViewController(nameOfRocket: "Falcon 1", nameOfImage: "Falcon1")
    let starShip = RocketViewController(nameOfRocket: "Starship", nameOfImage: "starship")
    
    // MARK: - Pages
    private lazy var pages: [UIViewController] = [
//        Test(),
        falconHeavy,
        falcon9,
        falcon1,
        starShip
    ]
    
    private let pageControl = UIPageControl()
    
    // MARK: - Init
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupPageControl()
        setViewControllers([pages[0]], direction: .forward, animated: true)
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад" // Новый текст для кнопки
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Setup PageControl
    private func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .systemGray

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource & UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentVC = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: currentVC) else { return }
        pageControl.currentPage = index
    }
}
