import UIKit
import SnapKit

final class PageViewController: UIPageViewController {
    
    private let api = RocketsAPI()
    private var rockets: [RocketsModel] = []
    
    private func loadData() {
        api.getData { [weak self] (rockets: [RocketsModel]) in
            guard let self = self else { return }
            if rockets.isEmpty { return }
            
            self.rockets = rockets
            
            let rocketNames = self.rockets.map { $0.name }
            self.pages = rocketNames.map { name in
                return RocketViewController(rocketName: name)
            }
            
            self.setupPageControl()
            self.setViewControllers([self.pages[0]], direction: .forward, animated: true)
        }
    }
    
    // MARK: - Pages
    private var pages: [UIViewController] = []
    
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
        
        loadData()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
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

        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(view.snp.centerX)
        }
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
