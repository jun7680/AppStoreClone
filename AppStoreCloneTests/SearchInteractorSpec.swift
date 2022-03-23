//
//  SearchInteractorSpec.swift
//  AppStoreCloneTests
//
//  Created by injun on 2022/03/23.
//

@testable import AppStoreClone
import Quick
import XCTest
import Nimble

class SearchInteractorSpec: QuickSpec {
    override func spec() {
        var sut: SearchInteractor!
        var presenter: SearchPresenterMock!
        var listener: SearchListenerMock!
        beforeEach {
            presenter = SearchPresenterMock()
            listener = SearchListenerMock()
            sut = .init(presenter: presenter)
            sut.listener = listener
        
        }
        
        describe("호출할때") {
            context("검색시작") {
                beforeEach {
                    sut.search(term: "카카오")
                }
                
                it("로딩 띄워야함") {
                    expect(presenter.loadingCallCount).to(equal(1))
                }
                
            }
        }
        
    }
}

