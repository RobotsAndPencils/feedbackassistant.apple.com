# Publishers.Future doesn't allow describing cancellation behaviour in initializer

FB6311565

Please describe the issue and what steps we can take to reproduce it:

I was pleased to see that Publishers.Future provided an initializer that made it easy to wrap existing asynchronous APIs in order to adapt them to the Combine API. The way that this initializer works is similar to other libraries I've used in the past, like PromiseKit. It is unclear if or how Publishers.Future supports implementing cancellation work that should occur when a subscriber invoked Cancellable.cancel(). I expected to be able to somehow provide a closure that would be invoked in that situation. The reason I think this is important for Combine to provide is because it allows users of the framework to easily adapt existing asynchronous APIs that they're already using to be used alongside the other Combine API usage in their software. This would save a lot of developer time compared to requiring them to write their own Publishers for each use case, as seems to be done for Foundation types like URLSession: https://developer.apple.com/documentation/foundation/urlsession/datataskpublisher.

For example:

```
Publishers.Future<Query, Error> { promise in
    let task = self.fetch(query: query, cachePolicy: cachePolicy, queue: queue) { result, error in
        if let error = error {
            promise(.failure(error))
            return
        }

        promise(.success(result))
    }

    // Where or how do I describe that `task.cancel()` should be invoked when a subscriber cancels the subscription?
}
```

In my investigation, RxSwift's Single type has a method "create" which allows returning a Disposable. https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md#creating-a-single It seems like similar functionality could be added to Publishers.Future, or perhaps be a part of a new, distinct type like Publishers.CancellableFuture, that would allow returning a cancellation closure from the attemptToFulfill initializer argument. In other words, it would have an initializer with this signature:

`typealias Cancellation = () -> Void`
`public init(_ attemptToFulfill: @escaping (@escaping Publishers.Future<Output, Failure>.Promise) -> Cancellation)`

instead of this one:

`public init(_ attemptToFulfill: @escaping (@escaping Publishers.Future<Output, Failure>.Promise) -> Void)`

