//
//  HeroesViewController.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 23.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

class HeroesViewController: UITableViewController {
    
    var ds: NetworkDataSource<MarvelCharacter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ds = NetworkDataSource<MarvelCharacter>(
            tableView: tableView,
            resource: MarvelCharacter.all
        )
        tableView.dataSource = ds
        tableView.tableFooterView = UIView()
        ds.fetch()
    }
}

//struct Cell<T, C: UITableViewCell> {
//    let reuseIndetifier: String
//    let updateCallback: (T, C) -> Void
//}

class AppCell<T: CellDisplayable>: UITableViewCell {
    
    static var id: String {
        return "HeroesCell"
    }
    
    init() {
        super.init(style: .subtitle, reuseIdentifier: AppCell.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(character: CellDisplayable) {
        textLabel?.text = character.mainTitle
        detailTextLabel?.text = character.subtitle
    }
}

class NetworkDataSource<T: CellDisplayable>: NSObject, UITableViewDataSource {
    
    private let activityIndicatorView = UIActivityIndicatorView()
    private let webservice = Webservice()
    
    private let tableView: UITableView
    private let resource: Resource<[T]>
    private let cell = AppCell<T>()
    
    private var resultArray = [T]() {
        didSet {
            print(resultArray)
        }
    }
    
    init(tableView: UITableView, resource: Resource<[T]>) {
        self.tableView = tableView
        self.resource = resource
        super.init()
        tableView.dataSource = self
        update()
    }
    
    func fetch() {
        webservice.get(resource: resource, completion: { [weak self] result in
            switch result {
            case .success(let array):
                self?.resultArray = array
                print(self?.resultArray)
            case .failure(_):
                self?.resultArray = []
                print("^ error")
            }
            self?.update()
        })
    }
    
    private func update() {
        DispatchQueue.main.async {
            if self.resultArray.count == 0 {
                self.tableView.addSubview(self.activityIndicatorView)
                self.tableView.bringSubview(toFront: self.activityIndicatorView)
                self.activityIndicatorView.startAnimating()
            } else {
                self.activityIndicatorView.removeFromSuperview()
            }
            self.tableView.reloadData()
        }        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppCell<T>()
        cell.update(character: resultArray[indexPath.row])
        return cell
    }
}
