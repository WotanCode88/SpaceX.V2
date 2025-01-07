import UIKit
import SnapKit

class RocketInfoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "RocketInfoCell"
    
    // Для упрощения создадим UI-элементы прямо в ячейке
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none // Отключение выделения
        
        // Настройка UI элементов
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .systemGray
        
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .white
        
        self.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-15)
            make.centerY.equalTo(contentView.snp.centerY)

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
