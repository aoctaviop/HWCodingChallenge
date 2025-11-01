//
//  URLProtocolStub.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import HWCodingChallenge
import Foundation

final class URLProtocolStub: URLProtocol {
    
    static var stub: (data: Data?, response: URLResponse?, error: Error?)?
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest
    {
        request
    }
    
    override func startLoading() {
        if let data = URLProtocolStub.stub?.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLProtocolStub.stub?.response {
            client?.urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
        }
        
        if let error = URLProtocolStub.stub?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
}
