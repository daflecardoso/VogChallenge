//
//  BaseViewModel.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    
    internal let disposeBag = DisposeBag()
    private let handleError = HandleError()
    
    private let _onError = PublishSubject<ServiceError>()
    var onError: Driver<ServiceError> {
        return _onError.asDriver(onErrorJustReturn: .none)
    }
    
    internal let isLoading = PublishSubject<Bool>()
    var loading: Driver<Bool> {
        return isLoading.asDriver(onErrorJustReturn: false)
    }
    
    internal let isRequesting = PublishSubject<Bool>()
    var requesting: Driver<Bool> {
        return isRequesting.asDriver(onErrorJustReturn: false)
    }
    
    func handleError(error: Error) {
        let responseError = handleError.handle(with: error)
        _onError.onNext(responseError)
    }
}
