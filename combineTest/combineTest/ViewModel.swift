//
//  ViewModel.swift
//  combineTest
//
//  Created by Gregory SeungHyun Jin on 2019/12/26.
//  Copyright © 2019 Gregory SeungHyun Jin. All rights reserved.
//

import UIKit
import Combine

enum Action {
    case search(keyword:String)
}

class ViewModel {
    
    // Please Input Your Key
    // get key from here : https://superheroapi.com/#intro
    static let key:String = ""
    
    var cancellables = Set<AnyCancellable>()
    let searchKeyword   = CurrentValueSubject<String, Never>("")
    let action = PassthroughSubject<Action, Never>()
    var heros = CurrentValueSubject<[Heros],Never>([])
    
    weak var parent:ViewController?
    
    // Datasource for TableView
    var dataSource: UITableViewDiffableDataSource<ViewController.Section, Heros>? = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<ViewController.Section, Heros>! = nil
    
    init() {
        
        action.sink(receiveValue: { [weak self] action in
            self?.processAction(action)
        }).store(in: &cancellables)
        
        heros.sink { [weak self] (heros) in
            DispatchQueue.main.async {
                self?.updateUI(animated: true)
            }
        }.store(in: &cancellables)
        
    }
    
    func processAction(_ action: Action) {
        
        switch action {
            
        case .search(let keyword):
            
            if keyword == "" {
                self.heros.send([])
                return
            }
            let escapedString = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let urlStr = "https://superheroapi.com/api/\(ViewModel.key)/search/\(escapedString)"
            let url = URL(string: urlStr)!
            
            URLSession.shared
                .dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: BaseArrayResponse<Heros>.self, decoder: JSONDecoder())
                .mapError({ (error) -> Error in
                    return error
                })
                .sink(receiveCompletion: { (comp:Subscribers.Completion<Error>) in
                    
                }, receiveValue: { (resp:BaseArrayResponse<Heros>) in
                    self.heros.send(resp.results ?? [])
                })
                .store(in: &cancellables)
            
            
        }
    }
    
    func updateUI(animated: Bool = true) {
        currentSnapshot = NSDiffableDataSourceSnapshot<ViewController.Section, Heros>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(self.heros.value, toSection: .main)
        self.dataSource?.apply(currentSnapshot, animatingDifferences: animated)
        
    }
}


