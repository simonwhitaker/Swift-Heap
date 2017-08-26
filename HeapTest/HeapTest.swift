//
//  HeapTest.swift
//  HeapTest
//
//  Created by Simon on 30/07/2017.
//  Copyright © 2017 Simon Whitaker. All rights reserved.
//

import XCTest

struct StringWithLength {
  let string: String;
  let length: Int;
  init(_ string: String) {
    self.string = string
    self.length = string.characters.count
  }
}

struct ComparableStringWithLength: Comparable {
  let string: String;
  let length: Int;
  init(_ string: String) {
    self.string = string
    self.length = string.characters.count
  }

  static func < (lhs: ComparableStringWithLength, rhs: ComparableStringWithLength) -> Bool {
    return lhs.length < rhs.length;
  }

  static func == (lhs: ComparableStringWithLength, rhs: ComparableStringWithLength) -> Bool {
    return lhs.length == rhs.length;
  }
}

class HeapTest: XCTestCase {
  func testAddAndTop() {
    var h = Heap<Int>();

    h.add(34);
    XCTAssertEqual(h.top!, 34);

    h.add(21);
    XCTAssertEqual(h.top!, 21);

    h.add(22);
    XCTAssertEqual(h.top!, 21);

    h.add(2);
    XCTAssertEqual(h.top!, 2);
  }

  func testValidation() {
    var h = Heap<Int>()

    for _ in 0 ..< 100 {
      h.add(Int(arc4random()));
    }

    XCTAssertTrue(h.validate());
  }

  func testRemoveFirst() {
    var h = Heap<Int>()

    for _ in 0 ..< 100 {
      h.add(Int(arc4random()));
    }

    let expected = h.top!;
    XCTAssertTrue(h.validate());
    XCTAssertEqual(h.removeFirst(), expected);
  }

  func testDefaultTypeIsMinHeap() {
    var h = Heap<Int>();
    h.add(0);
    h.add(1);
    XCTAssertEqual(h.top!, 0);
  }

  func testTopIsMinForMinHeap() {
    var h = Heap<UInt32>();
    var min = UInt32.max;
    for _ in 0 ..< 10000 {
      let n = arc4random();
      if n < min {
        min = n;
      }
      h.add(n);
    }
    XCTAssertEqual(h.top!, min);
  }

  func testTopIsMaxForMaxHeap() {
    var h = Heap<UInt32>(comparator: >);
    var max = UInt32.min;
    for _ in 0 ..< 10000 {
      let n = arc4random();
      if n > max {
        max = n;
      }
      h.add(n);
    }
    XCTAssertEqual(h.top!, max);
  }

  func testRemoveFirstRetainsValidity() {
    var h = Heap<Int>()

    let max = 9
    for i in 0...max {
      h.add(max - i);
    }

    XCTAssertTrue(h.validate());
    let _ = h.removeFirst();
    XCTAssertTrue(h.validate());
  }

  func testString() {
    var h = Heap<String>();
    h.add("b");
    h.add("c");
    XCTAssertEqual(h.top!, "b");
    h.add("a");
    XCTAssertEqual(h.top!, "a");
  }

  func testCustomComparator() {
    var h = Heap<StringWithLength> { $0.length < $1.length }
    h.add(StringWithLength("aaa"));
    h.add(StringWithLength("b"));
    h.add(StringWithLength("cc"));
    XCTAssertEqual(h.top!.string, "b");
  }

  func testCustomComparableType() {
    var h = Heap<ComparableStringWithLength>();
    h.add(ComparableStringWithLength("aaa"));
    h.add(ComparableStringWithLength("b"));
    h.add(ComparableStringWithLength("cc"));
    XCTAssertEqual(h.top!.string, "b");
  }
}
