import Combine

extension Publishers {
    struct CancellableFuture<Output, Failure>: Publisher where Failure: Error {
        typealias Cancellation = () -> Void
        typealias Promise = (Swift.Result<Output, Failure>) -> Void

        let attemptToFulfill: (@escaping Promise) -> Cancellation

        class Sub: Subscription {
            let onRequest: () -> Void
            let onCancel: Cancellation

            init(onRequest: @escaping () -> Void, onCancel: @escaping Cancellation) {
                self.onRequest = onRequest
                self.onCancel = onCancel
            }

            func request(_ demand: Subscribers.Demand) {
                guard demand > .none else { return }
                onRequest()
            }

            func cancel() {
                onCancel()
            }
        }

        init(_ attemptToFulfill: @escaping (@escaping Promise) -> Cancellation) {
            self.attemptToFulfill = attemptToFulfill
        }

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            var onCancel: Cancellation?

            let sub = Sub(onRequest: {
                onCancel = self.attemptToFulfill { result in
                    switch result {
                    case .success(let output):
                        _ = subscriber.receive(output)
                        subscriber.receive(completion: .finished)
                    case .failure(let error):
                        subscriber.receive(completion: .failure(error))
                    }
                }
            }, onCancel: {
                onCancel?()
            })

            subscriber.receive(subscription: sub)
        }
    }
}
