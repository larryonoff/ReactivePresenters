//
//  Presentable.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 08/06/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import ReactiveCocoa

public protocol Presentable {
    associatedtype Presenters

    func present(presenters: Presenters) -> Disposable?
}
