//
//  UserCellView.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/14.
//

import UIKit
import Combine

class UserCellView: UICollectionViewCell, SwinjectSupport {
    
    private lazy var imageAPI = resolveInstance(ImageAPI.self)
    
    @Published var user: User?
    @Published var image: UIImage?
    
    weak var apiHandler: APIHandler?
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var imageView: UIImageView?
    private var genderLabel: UILabel?
    private var ageLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func layout() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 5
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        contentView.addSubviewForAutoLayout(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
        ])
        
        self.imageView = image
        
        let attributeContainer = UIStackView()
        attributeContainer.axis = .horizontal
        attributeContainer.alignment = .center
        attributeContainer.distribution = .equalSpacing
        contentView.addSubviewForAutoLayout(attributeContainer)
        
        NSLayoutConstraint.activate([
            attributeContainer.topAnchor.constraint(equalTo: image.bottomAnchor),
            attributeContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            attributeContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            attributeContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        let gender = UILabel()
        gender.font = UIFont.systemFont(ofSize: 16)
        
        let age = UILabel()
        age.font = UIFont.systemFont(ofSize: 16)
        
        attributeContainer.addArrangedSubview(gender)
        attributeContainer.addArrangedSubview(age)
        
        self.genderLabel = gender
        self.ageLabel = age
    }
    
    private func subscribe() {
        $user.sink { [weak self] in
            guard let user = $0,
                  let genderLabel = self?.genderLabel,
                  let ageLabel = self?.ageLabel else {
                return
            }
            
            genderLabel.text = user.gender?.toLabel()
            genderLabel.textColor = user.gender == .male ? .blue : .red
            
            ageLabel.text = "\(user.age ?? 0)\(LabelDef.ageSuffix)"
            
            genderLabel.bounds.size = genderLabel.intrinsicContentSize
            ageLabel.bounds.size = ageLabel.intrinsicContentSize
        }.store(in: &cancellables)
        
        $user.sink { [weak self] in
            guard let self = self,
                  let apiHandler = self.apiHandler,
                  let user = $0 else {
                return
            }
            
            apiHandler.request(requester: {
                self.imageAPI.getUserDetailPictureA(userId: user.id)
            }) {
                self.image = $0
            }?.store(in: &self.cancellables)
        }.store(in: &cancellables)
        
        $image.sink { [weak self] in
            guard let image = $0,
                  let imageView = self?.imageView else {
                return
            }
            imageView.image = image
        }.store(in: &cancellables)
    }
}
