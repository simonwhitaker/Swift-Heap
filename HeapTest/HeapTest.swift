//
//  HeapTest.swift
//  HeapTest
//
//  Created by Simon on 30/07/2017.
//  Copyright © 2017 Simon Whitaker. All rights reserved.
//

import XCTest

class HeapTest: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testAddAndTop() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    var h: Heap<Int> = Heap<Int>();

    h.add(34);
    XCTAssertEqual(h.top(), 34);

    h.add(21);
    XCTAssertEqual(h.top(), 21);

    h.add(22);
    XCTAssertEqual(h.top(), 21);

    h.add(2);
    XCTAssertEqual(h.top(), 2);
  }

  func testValidation() {
    var h: Heap<Int> = Heap<Int>()

    for _ in 0 ..< 100 {
      h.add(Int(arc4random()));
    }

    XCTAssertTrue(h.validate());
  }

  func testRemoveFirst() {
    var h: Heap<Int> = Heap<Int>()

    for _ in 0 ..< 100 {
      h.add(Int(arc4random()));
    }

    let expected = h.top();
    XCTAssertTrue(h.validate());
    XCTAssertEqual(h.removeFirst(), expected);
  }

  func testDefaultTypeIsMinHeap() {
    var h: Heap<UInt32> = Heap<UInt32>();
    h.add(0);
    h.add(1);
    XCTAssertEqual(h.top(), 0);
  }

  func testTopIsMinForMinHeap() {
    var h: Heap<UInt32> = Heap<UInt32>(heapType: .minHeap);
    var min: UInt32 = UInt32.max;
    for _ in 0 ..< 10000 {
      let n = arc4random();
      if n < min {
        min = n;
      }
      h.add(n);
    }
    XCTAssertEqual(h.top(), min);
  }

  func testTopIsMaxForMaxHeap() {
    var h: Heap<UInt32> = Heap<UInt32>(heapType: .maxHeap);
    var max: UInt32 = UInt32.min;
    for _ in 0 ..< 10000 {
      let n = arc4random();
      if n > max {
        max = n;
      }
      h.add(n);
    }
    XCTAssertEqual(h.top(), max);
  }

  func testRemoveFirstRetainsValidity() {
    var h: Heap<Int> = Heap<Int>()

    let max = 99
    for i in 0 ... 99 {
      h.add(max - i);
    }

    XCTAssertTrue(h.validate());
    let _ = h.removeFirst();
    XCTAssertTrue(h.validate());
  }
}
