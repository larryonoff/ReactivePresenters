//
//  AnonymousPresenter.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 29/05/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import ReactiveCocoa

///
public typealias AnonymousPresenter = Presenter<Void>

extension Presenter {
    ///
    public func anonymized(with element: Element) -> AnonymousPresenter {
        return AnonymousPresenter { _ in self.present(element) }
    }
}