//
//  MenuViewController.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 17.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    private var buttons = [UIButton]()
    
    private let menuViewModel: MenuViewModel
    
    init(menuViewModel: MenuViewModel) {
        self.menuViewModel = menuViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupController()
    }
    
    private func setupController() {
        title = "Menu"
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setupStackView() {
        view.addConstrainedSubview(subview: stackView, constraints: [
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0 / 6.0)
        ])
        for option in menuViewModel.menuOptions {
            setupButtonWithTitle(title: option.rawValue)
        }
    }
    
    private func setupButtonWithTitle(title: String) {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        button.setTitle(title.uppercased(), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), for: .normal)
        buttons.append(button)
        stackView.addArrangedSubview(button)
    }
    
    @objc func buttonTouchUp(button: UIButton) {
        menuViewModel.userTouchedOptionWithString(button.title(for: .normal) ?? "")
    }
}
