//
//  SingleExtensions.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import RxSwift
import RxCocoa

extension PrimitiveSequence where Trait == SingleTrait {
    
    func loading(_ isloading: PublishSubject<Bool>) -> PrimitiveSequence<SingleTrait, Element> {
        return self.do(onSuccess: { _ in
            isloading.onNext(false)
        }, onError: { _ in
            isloading.onNext(false)
        }, onSubscribe: {
            isloading.onNext(true)
        })
    }
    
    func requesting(_ isRequesting: PublishSubject<Bool>) -> PrimitiveSequence<SingleTrait, Element> {
        return self.do(onSuccess: { _ in
            isRequesting.onNext(false)
        }, onError: { _ in
            isRequesting.onNext(false)
        }, onSubscribe: {
            isRequesting.onNext(true)
        })
    }
}
