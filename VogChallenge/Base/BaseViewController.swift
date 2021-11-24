//
//  BaseViewController.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift

class BaseViewController: UIViewController {
    
    internal var baseViewModel: BaseViewModel? {
        return nil
    }
    internal let disposeBag = DisposeBag()
    internal let hud = CustomLoadingView()
    private var banner: GrowingNotificationBanner?
    
    internal var requestingViews: [UIButton] {
        return []
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bw
        setup()
    }
    
    private func setup() {
        setupLoading()
        bindLoading()
        bindRefreshing()
        bindError()
    }
    
    internal func setupLoading() {
        view.addSubview(hud)
        hud.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            hud.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hud.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        hud.isHidden = true
    }
    
    internal func bindLoading() {
        baseViewModel?
            .loading
            .drive(onNext: { [unowned self] isLoading in
                self.view.bringSubviewToFront(self.hud)
                hud.isHidden = !isLoading
            }).disposed(by: disposeBag)
    }
    
    private func bindRefreshing() {
        baseViewModel?
            .requesting
            .map { !$0 }
            .drive(onNext: { [unowned self] isEnabled in
                self.requestingViews.forEach { buttons in
                    buttons.isEnabled = isEnabled
                }
            }).disposed(by: disposeBag)
    }
    
    internal func bindError() {
        baseViewModel?
            .onError
            .drive(onNext: { [unowned self] error in
                switch error {
                case .shouldSignIn:
                    KeyChainCache.shared.removeSignInData()
                default: break
                }
                self.showBanner(message: error.errorMessage, style: .danger, duration: 5)
            }).disposed(by: disposeBag)
    }
    
    internal func showBanner(title: String? = nil, message: String, style: BannerStyle, duration: TimeInterval = 3) {
        banner?.dismiss()
        let logo = UIImageView(image: UIImage(named: "AppIcon")).apply {
            let height: CGFloat = 24
            $0.snp.makeConstraints { $0.width.height.equalTo(height) }
            $0.layer.cornerRadius = height / 2
            $0.clipsToBounds = true
        }
        banner = GrowingNotificationBanner(title: title,
                                                subtitle: message,
                                                leftView: logo,
                                                rightView: nil,
                                                style: style,
                                                colors: nil)
        banner?.duration = duration
        banner?.show()
    }
    
    deinit {
        debugPrint("your screen \(self) has been removed from memory")
    }
}
