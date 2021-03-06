//
//  PresenterProtocol.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 29/05/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import ReactiveCocoa

public protocol PresenterProtocol {
    
    /// Type of element to be presented.
    associatedtype Element
    
    /// Presents element.
    func present(element: Element) -> Disposable?
}

extension PresenterProtocol where Element == Void {
    public static var empty: Presenter<Void> {
        return Presenter { return nil }
    }
}

extension PresenterProtocol {
    ///
    public func anonymized(with element: Element) -> Presenter<Void> {
        return Presenter<Void> { _ in self.present(element) }
    }
}

extension PresenterProtocol {

    // Subscribes and presents next element with a given presenter by the replacing the previous one.
    func present<Error: ErrorType>(signal signal: Signal<Element, Error>) -> Disposable? {
        let serialDisposable = SerialDisposable()

        let disposable = CompositeDisposable()
        disposable += serialDisposable
        disposable += signal
            .observeResult {
                if let value = $0.value {
                    serialDisposable.innerDisposable = self.present(value)
                } else {
                    serialDisposable.innerDisposable = nil
                }
            }

        return disposable
    }

    // Subscribes and presents next `Optional` element with a given presenter by the replacing the previous one.
    func present<Error: ErrorType>(signal signal: Signal<Element?, Error>) -> Disposable? {
        let serialDisposable = SerialDisposable()
        
        let disposable = CompositeDisposable()
        disposable += serialDisposable
        disposable += signal
            .observeResult {
                if let value = $0.value?.optional {
                    serialDisposable.innerDisposable = self.present(value)
                } else {
                    serialDisposable.innerDisposable = nil
                }
            }
        
        return disposable
    }

    // Subscribes and presents next element with a given presenter by the replacing the previous one.
    func present<Error: ErrorType>(producer producer: SignalProducer<Element, Error>) -> Disposable? {
        let serialDisposable = SerialDisposable()
        
        let disposable = CompositeDisposable()
        disposable += serialDisposable
        disposable += producer
            .startWithResult {
                if let value = $0.value {
                    serialDisposable.innerDisposable = self.present(value)
                } else {
                    serialDisposable.innerDisposable = nil
                }
            }

        return disposable
    }
    
    // Subscribes and presents next `Optional` element with a given presenter by the replacing the previous one.
    func present<Error: ErrorType>(producer producer: SignalProducer<Element?, Error>) -> Disposable? {
        let serialDisposable = SerialDisposable()
        
        let disposable = CompositeDisposable()
        disposable += serialDisposable
        disposable += producer
            .startWithResult {
                if let value = $0.value?.optional {
                    serialDisposable.innerDisposable = self.present(value)
                } else {
                    serialDisposable.innerDisposable = nil
                }
            }
        
        return disposable
    }
}

infix operator <~ {
    associativity right

    // Binds tighter than assignment but looser than everything else.
    precedence 93
}

// Presents an element with a given presenter.
public func <~ <P: PresenterProtocol>(presenter: P, element: P.Element) -> Disposable? {
    return presenter.present(element)
}

// Subscribes and presents next element with a given presenter by the replacing the previous one.
public func <~ <P: PresenterProtocol, E: ErrorType>(presenter: P, signal: Signal<P.Element, E>) -> Disposable? {
    return presenter.present(signal: signal)
}

// Subscribes and presents next `Optional` element with a given presenter by the replacing the previous one.
public func <~ <P: PresenterProtocol, E: ErrorType>(presenter: P, signal: Signal<P.Element?, E>) -> Disposable? {
    return presenter.present(signal: signal)
}

// Subscribes and presents next element with a given presenter by the replacing the previous one.
public func <~ <P: PresenterProtocol, E: ErrorType>(presenter: P, producer: SignalProducer<P.Element, E>) -> Disposable? {
    return presenter.present(producer: producer)
}

// Subscribes and presents next `Optional` element with a given presenter by the replacing the previous one.
public func <~ <P: PresenterProtocol, E: ErrorType>(presenter: P, producer: SignalProducer<P.Element?, E>) -> Disposable? {
    return presenter.present(producer: producer)
}

// Subscribes and presents next element with a given presenter by the replacing the previous one.
public func <~ <Presenter: PresenterProtocol, Property: PropertyType where Presenter.Element == Property.Value>(presenter: Presenter, property: Property) -> Disposable? {
    return presenter <~ property.producer
}
