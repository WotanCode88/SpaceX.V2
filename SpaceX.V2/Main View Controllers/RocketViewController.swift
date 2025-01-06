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
    
    private let nameOfImage: String
        
    private lazy var img: UIImageView = {
        let img = UIImageView()
        if let image = UIImage(named: nameOfImage) {
            img.image = image
        } else {
            // Если изображение с таким именем не найдено, используйте изображение по умолчанию
            img.image = UIImage(named: "defaultImageName") // Имя изображения по умолчанию
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
    
    init (nameOfRocket: String, nameOfImage: String) {
        self.rocketName = nameOfRocket
        self.nameOfImage = nameOfImage
        
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
        // Убедитесь, что если существует старое представление, оно будет удалено
        horizontalView?.removeFromSuperview()

        // Создайте новый HorizontalView и добавьте его в иерархию представлений
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

    
    private lazy var allInfoView = BlockOfInfoView(nameOfRocket: rocketName)
    
    //MARK: - setupSecondContent

    private func setupSecondContent() {
        contentView.addSubview(allInfoView)
        contentView.addSubview(rocketLaunchButton)
        
        allInfoView.snp.makeConstraints { make in
            make.top.equalTo(titleOfPage.snp.bottom).offset(140)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        rocketLaunchButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(allInfoView.snp.bottom).offset(20)
        }
    }
}
