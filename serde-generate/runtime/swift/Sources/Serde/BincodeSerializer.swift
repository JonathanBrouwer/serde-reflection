//  Copyright (c) Facebook, Inc. and its affiliates.

import Foundation

public enum BincodeSerializerError: Error {
    case invalidInput(issue: String)
}

public class BincodeSerializer: BinarySerializer {
    public let MAX_LENGTH: Int = 1 << 31 - 1

    public init() {
        super.init(maxContainerDepth: Int.max)
    }

    override public func serialize_len(value: Int) throws {
        if value < 0 || value > MAX_LENGTH {
            throw BincodeSerializerError.invalidInput(issue: "Invalid length value")
        }
        try serialize_u64(value: UInt64(value))
    }

    override public func serialize_variant_index(value: UInt32) throws {
        try serialize_u32(value: value)
    }

    override public func sort_map_entries(offsets _: [Int]) {
        // Not required by the format.
    }
}
