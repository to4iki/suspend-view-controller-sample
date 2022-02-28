import UIKit

extension UIViewController {
    func presentAsync(_ viewController: SuspendableViewController, animated: Bool, completion: (() -> Void)? = nil) async {
        if Task.isCancelled {
            return
        }
        present(viewController, animated: animated, completion: completion)
        await withCheckedContinuation { continuation in
            viewController.didDisappearHandler = {
                continuation.resume()
            }
        }
    }

    func presentThrowingAsync(_ viewController: SuspendableViewController, animated: Bool, completion: (() -> Void)? = nil) async throws {
        try Task.checkCancellation()
        present(viewController, animated: animated, completion: completion)
        await withCheckedContinuation { continuation in
            viewController.didDisappearHandler = {
                continuation.resume()
            }
        }
    }

    func presentCancellationAsync(_ viewController: SuspendableViewController, animated: Bool, completion: (() -> Void)? = nil) async {
        if Task.isCancelled {
            return
        }
        present(viewController, animated: animated, completion: completion)
        await withTaskCancellationHandler(
            handler: {
                print("[\(type(of: viewController))]","cancel handler")
                Task { @MainActor in
                    viewController.dismiss(animated: true)
                }
            },
            operation: {
                await withCheckedContinuation { continuation in
                    viewController.didDisappearHandler = {
                        continuation.resume()
                    }
                }
            }
        )
    }
}
