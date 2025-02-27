import UIKit
import SnapKit

final class RocketViewController: UIViewController {
    //MARK: - UI

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 50
        return view
    }()
        
    private lazy var img: UIImageView = {
        let img = UIImageView()
        if let image = UIImage(named: rocketName) {
            img.image = image
        }
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let rocketName: String
    
    private lazy var titleOfPage: UILabel = {
        let title = UILabel()
        title.text = rocketName
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 24)
        return title
    }()

    let settingButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "gearshape")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemGray
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addSubview(imageView)
        return button
    }()
     
    let rocketLaunchButton = RocketLaunchButton()
    
    init (rocketName: String) {
        self.rocketName = rocketName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
                  
        setupImageView()
        setupView()
        setupFirstContent()
        setupSecondContent()
        addTargets()
        createHorizontalView()
    }

    //MARK: - setupViews
    
    private func setupImageView() {
        view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(300)
        }
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //scrollView
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        //contentView
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(160)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(840)
        }
    }
    
    //MARK: - setupFirstContent
    
    private func setupFirstContent() {
        contentView.addSubview(titleOfPage)
        contentView.addSubview(settingButton)
        
        titleOfPage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(40)
            make.top.equalTo(contentView.snp.top).offset(60)
        }
        
        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleOfPage.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-40)
            make.height.width.equalTo(40)
        }
    }
    
    //MARK: - setupHorizontal
    private var horizontalView: HorizontalView!

    private func createHorizontalView() {
        horizontalView?.removeFromSuperview()

        horizontalView = HorizontalView(rocketName: rocketName)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(horizontalView)
        
        setupHorizontalView()
    }

    private func setupHorizontalView() {
        horizontalView.snp.makeConstraints { make in
            make.top.equalTo(titleOfPage.snp.bottom).offset(40)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.height.equalTo(100)
        }
    }

    //MARK: - setupSecondContent
    lazy var rocketInfoViewController = RocketInfoTableViewController(rocketName: rocketName)

    private func setupSecondContent() {
        contentView.addSubview(rocketInfoViewController.tableView)
        contentView.addSubview(rocketLaunchButton)
        
        rocketInfoViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(titleOfPage.snp.bottom).offset(160)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(rocketLaunchButton.snp.top).offset(-5)
        }
        
        rocketLaunchButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
    }

}
