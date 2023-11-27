//
//  MemCell.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

final class MemCell: UITableViewCell {
    
    // MARK: - Private UI Properties
    private lazy var mainView: UIView = {
        var mainView = UIView()
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOpacity = 0.5 // Прозрачность тени
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3) // Смещение тени относительно view
        mainView.layer.shadowRadius = 3 // Радиус размытия тени
        return mainView
    }()
    
    private lazy var questionLabel: UILabel = {
        var predLabel = UILabel()
        predLabel.text = "What I need to do tomorrow?"
        predLabel.numberOfLines = 0
        return predLabel
    }()
    
    private lazy var memImageView: UIImageView = {
        var mem = UIImageView()
        mem.image = UIImage(systemName: "questionmark")
        mem.layer.cornerRadius = 10
        mem.clipsToBounds = true
        return mem
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with prediction: Prediction) {
        memImageView.image = UIImage(data: prediction.imageData)
        questionLabel.text = prediction.question
    }
    
    // MARK: - Private Methods
    private func setViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(questionLabel)
        mainView.addSubview(memImageView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(memImageView.snp.left).offset(-20)
//            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        memImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(60)
        }
    }
}
