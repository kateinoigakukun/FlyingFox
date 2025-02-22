//
//  HTTPClientTests.swift
//  FlyingFox
//
//  Created by Simon Whitty on 8/06/2024.
//  Copyright © 2024 Simon Whitty. All rights reserved.
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/swhitty/FlyingFox
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#if canImport(Darwin)
@_spi(Private) import struct FlyingFox._HTTPClient
@testable import FlyingFox
@testable import FlyingSocks
import Foundation
import Testing

struct HTTPClientTests {

    @Test
    func client_sends_request() async throws {
        // given
        let server = HTTPServer(address: .loopback(port: 0))
        let task = Task { try await server.run() }
        defer { task.cancel() }
        let client = _HTTPClient()

        // when
        let port = try await server.waitForListeningPort()
        let response = try await client.sendHTTPRequest(HTTPRequest.make(), to: .loopback(port: port))

        // then
        #expect(response.statusCode == .notFound)
    }
}
#endif
