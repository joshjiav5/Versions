import Foundation

extension Array {

  func at(index: Int) -> Element? {
    if index >= 0 && index < self.count {
      return self[index]
    }
    return nil
  }
}

public struct Version : Equatable,  Comparable{

  public let major  : Int
  public let minor  : Int
  public let patch  : Int
  public let string : String?

  
  public init?(_ version: String) {
    
    let parts: Array<String> = version.characters.split { $0 == "." }.map { String($0) }
    if let major = parts.at(0), minor = parts.at(1), patch = parts.at(2), majorInt = Int(major), minorInt = Int(minor), patchInt = Int(patch) {
      self.major = majorInt
      self.minor = minorInt
      self.patch = patchInt
      string = version
    } else {
      //Failed to Initialize Version
      return nil
    }
  }
}


//MARK: - Equatable

public func == (lhs: Version, rhs: Version) -> Bool {
  return lhs.string == rhs.string
}


public func == (lhs: Version, rhs: Version?) -> Bool {
  switch (rhs) {
  case let .Some(r): return lhs.string == r.string
  case .None: return false
  }
}


//MARK: - Comparable

public func < (lhs: Version, rhs: Version) -> Bool {
  return lhs.string!.compare(rhs.string!, options: NSStringCompareOptions.NumericSearch) == .OrderedAscending
}
