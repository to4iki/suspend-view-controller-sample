import UIKit

final class FirstViewController: UIViewController {
    private var task: Task<Void, Never>?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        print("[\(type(of: self))]: \(#function)")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let featureAButton = UIButton(primaryAction: .init(handler: aButtonHandler(action:)))
        featureAButton.setTitle("presentAsync", for: .normal)

        let featureBButton = UIButton(primaryAction: .init(handler: bButtonHandler(action:)))
        featureBButton.setTitle("presentThrowingAsync", for: .normal)

        let featureCButton = UIButton(primaryAction: .init(handler: cButtonHandler(action:)))
        featureCButton.setTitle("presentCancellationAsync", for: .normal)

        let stackView = UIStackView(arrangedSubviews: [featureAButton, featureBButton, featureCButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension FirstViewController {
    private func aButtonHandler(action: UIAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.cancelTask()
        }
        self.task = Task {
            let coverVC1 = CoverViewController(rootView: CoverView(item: .red))
            await presentAsync(coverVC1, animated: true)

            let coverVC2 = CoverViewController(rootView: CoverView(item: .yellow))
            await presentAsync(coverVC2, animated: true)
        }
    }

    private func bButtonHandler(action: UIAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.cancelTask()
        }
        self.task = Task {
            do {
                let coverVC1 = CoverViewController(rootView: .init(item: .red))
                try await presentThrowingAsync(coverVC1, animated: true)

                let coverVC2 = CoverViewController(rootView: .init(item: .yellow))
                try await presentThrowingAsync(coverVC2, animated: true)

            } catch {
                print("[\(type(of: self))]:", "\(error)")
                dismiss(animated: true)
            }
        }
    }

    private func cButtonHandler(action: UIAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.cancelTask()
        }
        self.task = Task {
            let coverVC1 = CoverViewController(rootView: CoverView(item: .red))
            await presentCancellationAsync(coverVC1, animated: true)

            let coverVC2 = CoverViewController(rootView: CoverView(item: .yellow))
            await presentCancellationAsync(coverVC2, animated: true)
        }
    }

    private func cancelTask() {
        print("[\(type(of: self))]: \(#function)")
        task?.cancel()
    }
}
