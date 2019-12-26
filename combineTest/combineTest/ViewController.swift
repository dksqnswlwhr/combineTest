//
//  ViewController.swift
//  combineTest
//
//  Created by Gregory SeungHyun Jin on 2019/12/26.
//  Copyright © 2019 Gregory SeungHyun Jin. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // TableView Section //
    enum Section: CaseIterable {
        case main
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let viewModel:ViewModel = ViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel.parent = self
        self.configure()
        self.configureDataSource()
    }
    
    func configure() {
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "HeroCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
        
        self.viewModel.heros
            .map { $0.count }
            .sink { [weak self] (heros) in
                DispatchQueue.main.async {
                    self?.descriptionLabel.text = "\(heros) Heros found."
                }
        }
        .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification,
                       object: searchTextField)
            .eraseToAnyPublisher()
            .map { (($0.object as! UITextField).text!) }
//            .filter({ (s) -> Bool in return s.count != 0 })
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink(receiveCompletion: { (comp:Subscribers.Completion<Never>) in
                print("TextField Subscription Completed.")
            }, receiveValue: { [weak self] (searchKeyword) in
                DispatchQueue.main.async {
                    self?.searchTextField.resignFirstResponder()
                }
                self?.viewModel.action.send(.search(keyword: searchKeyword))
            })
            .store(in: &cancellables)
    }
    
    func configureDataSource() {
        self.viewModel.dataSource = UITableViewDiffableDataSource<Section, Heros>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: Heros) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroCell
            cell?.heros.send(item)
            
            return cell
        }
        self.viewModel.dataSource?.defaultRowAnimation = .automatic
    }
}

