//
//  Presenter.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 29/05/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import ReactiveCocoa

public struct Presenter<Element>: PresenterProtocol {

    internal let binding: (Element) -> Disposable?
    
    /// Initializes a Presenter that will invoke the given closure.
    public init(_ binding: (Element) -> Disposable?) {
        self.binding = binding
    }
    
    /// Presents element.
    public func present(element: Element) -> Disposable? {
        let disposable = CompositeDisposable()

        disposable += UIScheduler()
            .schedule { disposable += self.binding(element) }

        return disposable
    }
}
