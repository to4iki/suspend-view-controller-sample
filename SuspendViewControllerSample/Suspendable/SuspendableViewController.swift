import UIKit

typealias SuspendableViewController = UIViewController & SuspendableViewControllerProtocol

@MainActor
protocol SuspendableViewControllerProtocol: AnyObject {
    var didDisappearHandler: (() -> Void)? { get set }
}
