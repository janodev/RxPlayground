
import RxSwift

exampleOf("Create observable sequences")
{
    _ = Observable.from([0,1,2,3,4,5])             // from array
    _ = Observable.from([1:"Hello",2:"World"])     // from dictionary
    _ = Observable.just("Hello Rx")                // from single element
    _ = Observable.of(1,2,3)                       // from variable list of elements
    _ = Observable<Int>.range(start: 1, count: 10) // from range of values
    _ = Observable<Void>.empty()                   // empty sequence. Sends one event: completed.
    _ = Observable<Any>.never()                    // sends no events (so it doesn’t terminate)
    
    // sequence that terminates immediately with error
    enum Cake: Error { case burnt }
    _ = Observable<Int>.error(Cake.burnt).subscribe { print($0) }
}

exampleOf("Different ways to write the subscribe method")
{
    let sequence = Observable.from([0.07])
    
    sequence.subscribe { event in
        switch event {
        case .next(let value):  print(value)
        case .error(let error): print(error)
        case .completed:        print("completed")
        }
    }
    
    sequence.subscribe { print($0) }
    
    sequence.subscribe({ (event: Event<Double>) in
        print(event)
    })
    
    sequence.subscribe(onNext: { element in
        print(element)
    }, onError: { error in
        print(error)
    }, onCompleted: {
        print("completed")
    }, onDisposed: {
        print("disposed")
    })
}

exampleOf("Cancel the subscription")
{
    // subscribe and cancel the subscription on deinit
    let bag = DisposeBag()
    _ = Observable.just("Hello")
        .subscribe (onNext:{ print($0) })
        .addDisposableTo(bag)
    
    // subscribe and cancel the subscription
    _ = Observable.just("Turtle")
        .subscribe { print($0) }
        .dispose()

}
