//
//  Heap.swift
//  Heap
//
//  Created by Simon on 30/07/2017.
//  Copyright © 2017 Simon Whitaker. All rights reserved.
//

import Foundation

extension Heap where T: Comparable {
  // If T is Comparable, add a convenience constructor that creates a min heap
  init() {
    self.init(comparator: <);
  }
}

struct Heap<T> {
  /*
   * Heap<T> stores its data in an array. For any element and index n, its
   * children are at 2n+1 and 2n+2.
   */
  typealias Comparator = (T, T) -> Bool;

  private var storage: Array<T>;
  private var comparator: Comparator;

  // Initialisation

  init(comparator: @escaping Comparator) {
    self.storage = Array<T>();
    self.comparator = comparator;
  }

  // Public properties

  var top: T? {
    get {
      return storage.first;
    }
  }

  var count: Int {
    get {
      return storage.count;
    }
  }

  // Public mutators

  mutating func add(_ newElement: T) {
    storage.append(newElement);
    self.siftUp(fromIndex: storage.count - 1);
  }

  mutating func removeFirst() -> T? {
    if let result = self.top,
      let tail = self.storage.popLast() {
      self.storage[0] = tail;
      self.siftDown(fromIndex: 0)
      return result;
    }
    return nil;
  }

  // Invariant maintainers

  mutating private func siftDown(fromIndex: Int) {
    let idx = fromIndex;

    for cidx in 2 * idx + 1 ... 2 * idx + 2 {
      if cidx < storage.count {
        let val = storage[idx];
        let cval = storage[cidx];
        if !comparator(val, cval) {
          storage[idx] = cval;
          storage[cidx] = val;
          self.siftDown(fromIndex: cidx);
        }
      }
    }
  }

  mutating private func siftUp(fromIndex: Int) {
    var idx = fromIndex;
    var pidx: Int;
    while idx > 0 {
      pidx = (idx - 1) / 2;
      let val = storage[idx];
      let pval = storage[pidx];
      if !comparator(pval, val) {
        storage[pidx] = val;
        storage[idx] = pval;
      }
      idx = pidx;
    }
  }

  // Validation

  func validate() -> Bool {
    for i in 0 ..< storage.count {
      if !validate(elementAt: i) {
        return false;
      }
    }
    return true;
  }

  func validate(elementAt: Int) -> Bool {
    let idx = elementAt;
    let cidx1 = 2 * idx + 1;
    let cidx2 = 2 * idx + 2;

    if cidx1 < storage.count && !comparator(storage[idx], storage[cidx1]) {
      return false;
    }
    if cidx2 < storage.count && !comparator(storage[idx], storage[cidx2]) {
      return false;
    }
    return true;
  }
}

