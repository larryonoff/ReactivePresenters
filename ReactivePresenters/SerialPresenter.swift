//
//  SerialPresenter.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 29/05/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import ReactiveCocoa

public final class SerialPresenter<Element>: PresenterProtocol {

    internal let binding: (Element) -> Disposable?

    public init(_ binding: (Element) -> Disposable?) {
        self.binding = binding
    }

    public init(_ binding: (Element) -> Presenter<Void>) {
        self.binding = { element in
            return binding(element).binding()
        }
    }

    deinit {
        _disposable?.dispose()
    }

    private var _disposable: SerialDisposable?

    private var disposable: SerialDisposable {
        if let disposable = _disposable where !disposable.disposed {
            return disposable
        }

        let newDisposable = SerialDisposable()
        _disposable = newDisposable
        return newDisposable
    }

    // MARK: PresenterProtocol

    public func present(element: Element) -> Disposable? {
        let disposable = CompositeDisposable()

        disposable += UIScheduler()
            .schedule { self.disposable.innerDisposable = self.binding(element) }

        return disposable
    }
}

extension Presenter {
    ///
    public var serialized: SerialPresenter<Element> {
        return SerialPresenter(binding)
    }
}
