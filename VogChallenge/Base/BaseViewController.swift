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
}
