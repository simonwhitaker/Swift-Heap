# An implementation of the heap data stucture in Swift

## Usage

A heap over a type that conform to Comparable is a min-heap by default.

``` swift
var h = Heap<Int>();
h.add(4);
h.add(9);
h.add(2);
let i = h.top! // i is 2
```

Pass a `comparator` argument to the constructor for custom behaviour. For example, to use a max heap:

``` swift
var h = Heap<Int>(comparator: >);
h.add(4);
h.add(9);
h.add(2);
let i = h.top! // i is 9
```

Or to order strings by length:

``` swift
var h = Heap<String> { $0.length < $1.length };
h.add("foo");
h.add("bar");
h.add("bo");
let s = h.top! // s is "bo"
```
