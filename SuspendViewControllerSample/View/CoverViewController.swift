import SwiftUI

// MARK: - CoverViewItem
enum CoverViewItem: Int {
    case red = 1
    case yellow = 2

    var titleText: String { "\(rawValue)" }

    var backgroundColor: Color {
        switch self {
        case .red:
            return .red
        case .yellow:
            return .yellow
        }
    }
}

// MARK: - CoverView
struct CoverView: View {
    var item: CoverViewItem

    var body: some View {
        ZStack {
            item.backgroundColor
            Text(item.titleText).font(.title)
        }
    }
}

// MARK: - CoverViewController
final class CoverViewController: UIHostingController<CoverView>, SuspendableViewControllerProtocol {
    var didDisappearHandler: (() -> Void)?

    private let titleText: String

    override init(rootView: CoverView) {
        self.titleText = rootView.item.titleText
        super.init(rootView: rootView)
    }

    deinit {
        print("[\(type(of: self))_\(titleText)]: \(#function)")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappearHandler?()
    }
}
